From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 29 Oct 2013 21:05:09 -0700
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <526E89E6.8010202@codethink.co.uk>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
 <20131028084455.GA20218@mudshark.cambridge.arm.com>
 <20131028085328.GI16735@n2100.arm.linux.org.uk>
 <526E89E6.8010202@codethink.co.uk>
Message-ID: <CAA3XUr0yr0Vh_rpM7bKJGBkOpWhOarUs=pRAx40mwqRp2V=mfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2013 08:59, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 28/10/13 08:53, Russell King - ARM Linux wrote:
>
>>> +#ifdef __ARMEB_
>>> +#define LOW_OFFSET     0x4
>>> +#define HIGH_OFFSET    0x0
>>> +#else
>>> +#define LOW_OFFSET     0x0
>>> +#define HIGH_OFFSET    0x4
>>> +#endif
>>>
>>> (spot the missing underscore).
>>
>>
>> Yep, well spotted.
>>
>> Well, we have some time to get this all fixed, so I'm going to drop
>> Ben's tree.  I think we need to first commit a patch to fix the error
>> in Santosh's patch
>
>
> Ok, shall I look at re-basing to -rc6?

I just fetched rmk/for-next as of 10/29/2013 8pm PST. I see that big
endian patch series is in. I believe conflict resolution 580dac83 in head.S
is correct. I've added typo and .align fix as in [1] to head.S and
tested BE image on TC2 in both ARM and THUMB2 modes - both boot
and look fine to me.

> I have a bug report with a change to the SCU reading for the SMP
> fix-up case which could do with fixing, so I could add this and send
> another pull request (complete with description this time).
>

IMHO it would be great if we fix SCU BE A9 SMP issue separately
later, and keep BE changes that are already in rmk/for-next.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/thread.html#207597

> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
