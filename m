From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 11 Aug 2011 18:31:20 -0700
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <4E2972B1.5070604@ti.com>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
	<4E2796DA.80001@gmail.com> <4E27BA10.3060203@ti.com>
	<20110721133033.GN26574@n2100.arm.linux.org.uk>
	<4E2902E7.6000108@ti.com>
	<13B9B4C6EF24D648824FF11BE896716203F2398D3A@dlee02.ent.ti.com>
	<4E2972B1.5070604@ti.com>
Message-ID: <CAJOA=zNu_xhen0mdcmnBw=wpYO1RtkDMBtT1_J8m8ysa1+ZHhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 5:53 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 7/22/2011 6:15 PM, Woodruff, Richard wrote:
>>
>>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>>> kernel-bounces at lists.infradead.org] On Behalf Of Shilimkar, Santosh
>>
>>>> With fixed IRQ migration and forcing CPU0 into an infinite WFI loop,
>>>> I can offline CPU0 and still have a running system.
>>>>
>>> The secure software runs only on CPU0 and that's the biggest limitation.
>>> Other issues like hand-shake as you pointed out, power sequencing etc
>>> can be worked around.
>>
>> As you know well some of the secure APIs work on CPU1 and others do not.
>>
>> I notice in other thread Russell made assumption about CPU1 being able to
>> use all because it could run some. This is not the case.
>>
> I clarified that on the other thread.

I've asked a few other ARM folks (out of band) to weigh in on this
thread to determine if their platform has similar limitations as OMAP.
 Unfortunately no one else has responded.

Still the limitation for OMAP remains.  Earlier in this thread I
provided an alternative to blacklisting CPU0 for all ARM platforms by
instead using a config option, but it received no comments.  What is
the best way to move forward?

Thanks,
Mike

> Regards
> Santosh
>
