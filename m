From: catalin.marinas@gmail.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 13:26:02 +0000
Subject: [PATCH 2/2] ARM: kexec: Fix crash_setup_regs() for ARMv7 and
	CONFIG_THUMB2_KERNEL
In-Reply-To: <20101117131146.GD19331@gw.healthdatacare.com>
References: <1289913141-8559-1-git-send-email-dave.martin@linaro.org>
	<1289913141-8559-2-git-send-email-dave.martin@linaro.org>
	<20101117131146.GD19331@gw.healthdatacare.com>
Message-ID: <AANLkTi=4MLpX7+DoXs4a8Bcx2QrFH5ZVjL8qA5G_smaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 13:11, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Tue, Nov 16, 2010 at 01:12:21PM +0000, Dave Martin wrote:
>> ?* Fix kexec build failure with CONFIG_THUMB2_KERNEL.
>>
>> ?* Avoids deprecated/forbidden sp and pc usage in for ARMv7 onwards,
>> retaining compatibility with older architecture versions.
>>
>> ?* The pc value saved to newregs is now aligned on a predictable
>> instruction boundary.
>>
>> (stmia { ... pc } or str pc has implementation-defined results
>> in most versions of the ARM architecutre, and is prohibited
>> (unpredictable) in Thumb-2.)
>>
>> ?* Switch to named inline asm arguments (else I get readily confused ...)
>>
>> The resulting code should be compatible with all architecture versions >= v3,
>> with or without CONFIG_THUMB2_KERNEL.
>>
>> Applies cleanly on v2.6.37-rc1.
>
> Quickly tested this and seems to work. So FWIW:
>
> Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

It's more like Tested-by :)  (unless you reviewed it as well, though
there seems to be some confusion between Reviewed-by and Acked-by).

-- 
Catalin
