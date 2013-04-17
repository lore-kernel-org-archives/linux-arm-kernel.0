From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Apr 2013 13:40:07 -0700
Subject: [PATCH v11 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <20130417202842.GS30416@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <516F016B.30603@codeaurora.org> <20130417202842.GS30416@pengutronix.de>
Message-ID: <516F08A7.8030009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/13 13:28, Uwe Kleine-K?nig wrote:
> Hello Stephen,
>
> On Wed, Apr 17, 2013 at 01:09:15PM -0700, Stephen Boyd wrote:
>> On 04/17/13 09:14, Uwe Kleine-K?nig wrote:
>>> +__v7m_proc_info:
>>> +	.long	0x000f0000		@ Required ID value
>>> +	.long	0x000f0000		@ Mask for ID
>>> +	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
>>> +	.long   0			@ proc_info_list.__cpu_io_mmu_flags
>>> +	b	__v7m_setup		@ proc_info_list.__cpu_flush
>>> +	.long	cpu_arch_name
>>> +	.long	cpu_elf_name
>>> +	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_IDIVT
>> Mainline is detecting HWCAP_IDIVT for v7 processors so you should be
>> able to leave that part out.
> I cannot confirm that. If I drop HWCAP_IDIVT here, /proc/cpuinfo changes
> as follows:
>
> -Features	: half thumb fastmult idivt 
> +Features	: half thumb fastmult
>
> Maybe I missed to call the respective function to autodetect that? I
> don't consider that an issue big enough to justify another round for
> this series. For me letting v11 hit mainline and fix detection later is
> ok. I'll take a note to look into this, but if you want to come up with
> a patch, don't hesitate :-)

The patch that introduces the detection is
8164f7af88d9ad3a757bd14f634b23997ee77f6b. Sorry I should have read this
patch more closely. I seem to recall that M profile doesn't have the
CPUID registers in a coprocessor so it won't work. Probably easier to
leave it as is for now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
