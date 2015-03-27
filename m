From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 27 Mar 2015 12:24:31 +0100
Subject: [PATCH v2] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <1949810.qILnBKuAJP@amdc1032>
References: <1426069206-13667-1-git-send-email-k.kozlowski@samsung.com>
 <55086CE0.6080905@kernel.org> <1426669047.29565.9.camel@AMDC1943>
 <1949810.qILnBKuAJP@amdc1032>
Message-ID: <CAJKOXPcYGeurqrKTCQBh6HcjPEpd=uxf58em4Xvd_yQO9tMp0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

How would you like to proceed? You did not respond to my email nor to
Bartlomiej's questions.

You questioned the "soc_is_exynos()". I replied but there was no
answer from you. My last reply:
2015-03-18 9:57 GMT+01:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Probably of_machine_is_compatible() could be used here but such change
> should be done in separate patch. This is fix for wrong usage of
> use_delayed_assertion so it should not mix with other changes in the
> code. This fixes one thing at a time. Fixing many things in one patch
> often leads to new errors or difficulties in debugging.

Bartlomiej's justification for it:
2015-03-18 11:29 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>> >
>> > Please use another way something like check ARM core rather than use
>> > 'soc_is_xxx()', as you know it is not acceptable now even it is just
>> > moving/modifying exist function though.
>
> Kukjin, could you please explain why 'soc_is_xxx()' usage inside
> arch/arm/mach-exynos/ code is not acceptable?  I know that it should
> not be used outisde of this directory because of multiplatform support
> but what is wrong with using it for arch/arm/mach-exynos/ code?
>
> I'm also not sure if -rc4 is a desirable time to be doing such changes
> (especially given that the patch in question is moving an existing code,
> not adding new 'soc_is_xxx()' users).
>
> [ Moreover of_machine_is_compatible() can be sometimes harmful as could
>   have been seen in commit ca489c58ef0b81 ("ARM: EXYNOS: Don't use LDREX
>   and STREX after disabling cache coherency" fix. ]

... and more.

As for the checking in LSI, I did not receive any answer.

To summarize:
Fixing this with this patch is an optimal way in my humble opinion because:
1. Fixes the problem.
2. Does not introduce regression.
3. Does not remove other features (reverting commits would do).
4. It was tested.
5. We are in late RC and second suspend-to-RAM still does not work.

Reverting commits or developing some kind of new patch (which details
you did not propose) is asking for some other troubles.

Best regards,
Krzysztof
