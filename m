From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Feb 2011 13:49:03 +0000
Subject: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
In-Reply-To: <87ei7fe8mk.fsf@ti.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com> <87ei7fe8mk.fsf@ti.com>
Message-ID: <AANLkTi=0ikmWaVSoerb71ZK=_fBETO54nTvYu-hGAPBR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 12:07 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> Dave Martin <dave.martin@linaro.org> writes:
>>
>>> ?* Use BSYM() to get the correct Thumb branch address
>>> ? ?for adr <Rd>, <label>
>>>
>>> ?* Fix an out-of-range ADR when building for ARM
>>>
>>> ?* Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>>
>>> ?* Remove deprecated/undefined PC-relative stores
>>>
>>> ?* Add the required ENDPROC() directive for each ENTRY().
>>>
>>> ?* .align before data words
>>>
>>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>>
>> I'm attempting to test this series with OMAP PM, but some changes here
>> don't compile for me.
>>
>> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50)
>>
>> First, I merged your arm/omap-thumb2+merged branch with my pm branch
>> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
> Sorry for the confusion, this patch should've been in reply to your v4
> version, since I merged with your 'arm/omap-thumb2+merged' branch from
> today.

If you are able to test off mode with CONFIG_THUMB2_KERNEL enabled,
that would be great.

I have some evidence that the resume path may be working in Thumb-2,
but I think I'm being bitten by erratum i583 (I have to disable the
workaround to even attempt to test off mode on Beagle xM)

Cheers
---Dave
