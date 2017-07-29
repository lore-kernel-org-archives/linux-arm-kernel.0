From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 29 Jul 2017 13:05:28 +0100
Subject: [RFC PATCH v1] net: ethernet: nb8800: Reset HW block in ndo_open
In-Reply-To: <f04a0cba-6c09-e9e4-f2d1-d8b2a7e276c9@free.fr> (Mason's message
 of "Sat, 29 Jul 2017 14:02:00 +0200")
References: <823b1540-b528-bbd7-7f99-5dc39a08868a@sigmadesigns.com>
 <yw1xk22slemx.fsf@mansr.com>
 <c1bf54ee-8634-23a1-abda-55bc3fafe2a8@sigmadesigns.com>
 <yw1xfudgl7am.fsf@mansr.com>
 <446e3a95-80c3-0742-9cb1-69a8dfc9b1ae@free.fr>
 <yw1x7eyrlc3s.fsf@mansr.com>
 <f04a0cba-6c09-e9e4-f2d1-d8b2a7e276c9@free.fr>
Message-ID: <yw1x379fla7r.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 29/07/2017 13:24, M?ns Rullg?rd wrote:
>
>> Until you figure out why it's getting stuck, we can't be sure
>> it isn't caused by something that could trigger at any time.
> Would you take a look at it, if I can reproduce on tango4?
>
> I have identified a 100% reproducible flaw.
> I have proposed a work-around that brings this down to 0
> (tested 1000 cycles of link up / ping / link down).
>
> In my opinion, upstream should consider this work-around
> for inclusion. I'd like to hear David's and Florian's
> opinion on the topic. It's always a pain to maintain
> out-of-tree patches.

I'm not saying it shouldn't be fixed.  I am saying we should make sure
we make the right fix, not just paper over one instance of a wider issue.

>> Yes, but by then you've reset those parameters to the defaults.
>
> Good catch. There is some non HW-related init in
> nb8800_hw_init().
>
> I'll take this opportunity to change flow control to
> off by default (it breaks several 100 Mbps switches).

I was told to have it on by default.  This is what most other drivers do
too.  If you have faulty switches, that's your problem.

-- 
M?ns Rullg?rd
