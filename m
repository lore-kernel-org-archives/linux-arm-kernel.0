From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 30 Oct 2013 11:23:03 -0700
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <20131030180109.GL16735@n2100.arm.linux.org.uk>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
 <20131028084455.GA20218@mudshark.cambridge.arm.com>
 <20131028085328.GI16735@n2100.arm.linux.org.uk>
 <526E89E6.8010202@codethink.co.uk>
 <20131030180109.GL16735@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr1K1s6+PYdOdOdR4CNbQaE2Ri_7Swao0C=PiRT5jHqSdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2013 11:01, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 28, 2013 at 03:59:34PM +0000, Ben Dooks wrote:
>> On 28/10/13 08:53, Russell King - ARM Linux wrote:
>>
>>>> +#ifdef __ARMEB_
>>>> +#define LOW_OFFSET     0x4
>>>> +#define HIGH_OFFSET    0x0
>>>> +#else
>>>> +#define LOW_OFFSET     0x0
>>>> +#define HIGH_OFFSET    0x4
>>>> +#endif
>>>>
>>>> (spot the missing underscore).
>>>
>>> Yep, well spotted.
>>>
>>> Well, we have some time to get this all fixed, so I'm going to drop
>>> Ben's tree.  I think we need to first commit a patch to fix the error
>>> in Santosh's patch
>>
>> Ok, shall I look at re-basing to -rc6?
>>
>> I have a bug report with a change to the SCU reading for the SMP
>> fix-up case which could do with fixing, so I could add this and send
>> another pull request (complete with description this time).
>
> Rebasing on a later kernel from Linus doesn't do much good, because the
> conflicting changes aren't in Linus' tree, but are part of Santosh's
> patch set for high physical memory for LPAE systems.
>
> I think we're fine with knowing what the merge fixes are now.  There's
> only one remaining problem left, which is a missing .align.  Someone
> needs to send a patch for that. :)

Sorry, I referenced [1], but actually Sricharan sent [2] which includes .align
fix as well as fix for __ARMEB_ typo and marked it as V2 for [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/thread.html#207597
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/207809.html

Is there anything else we need to do?

Thanks,
Victor
