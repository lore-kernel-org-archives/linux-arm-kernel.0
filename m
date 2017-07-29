From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 29 Jul 2017 08:18:57 -0700
Subject: [RFC PATCH v1] net: ethernet: nb8800: Reset HW block in ndo_open
In-Reply-To: <f04a0cba-6c09-e9e4-f2d1-d8b2a7e276c9@free.fr>
References: <823b1540-b528-bbd7-7f99-5dc39a08868a@sigmadesigns.com>
 <yw1xk22slemx.fsf@mansr.com>
 <c1bf54ee-8634-23a1-abda-55bc3fafe2a8@sigmadesigns.com>
 <yw1xfudgl7am.fsf@mansr.com> <446e3a95-80c3-0742-9cb1-69a8dfc9b1ae@free.fr>
 <yw1x7eyrlc3s.fsf@mansr.com> <f04a0cba-6c09-e9e4-f2d1-d8b2a7e276c9@free.fr>
Message-ID: <4ff343de-41c7-c309-04dc-983b5fe3e066@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2017 05:02 AM, Mason wrote:
> On 29/07/2017 13:24, M?ns Rullg?rd wrote:
> 
>> Until you figure out why it's getting stuck, we can't be sure
>> it isn't caused by something that could trigger at any time.
> Would you take a look at it, if I can reproduce on tango4?
> 
> I have identified a 100% reproducible flaw.
> I have proposed a work-around that brings this down to 0
> (tested 1000 cycles of link up / ping / link down).

Can you also try to get help from your HW resources to eventually help
you find out what is going on here? If anybody has access to that it
would be you.

> 
> In my opinion, upstream should consider this work-around
> for inclusion. I'd like to hear David's and Florian's
> opinion on the topic. It's always a pain to maintain
> out-of-tree patches.

I have to agree with Mans here that the commit message explanation is
not good enough to understand how the RX path is hosed after a call to
ndo_stop() it would be good, both for you and for the people maintaining
this driver to understand what happens exactly so the fix is correct,
understood and maintainable. The patch itself looks reasonable with the
limited description given, but it's the description itself that needs
changing. BTW, this should probably come with a Fixes: tag to identify
which commit (presumably the one introducing the driver) is being fixed.
-- 
Florian
