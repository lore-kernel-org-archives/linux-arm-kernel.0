From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Apr 2013 13:09:15 -0700
Subject: [PATCH v11 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <516F016B.30603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/13 09:14, Uwe Kleine-K?nig wrote:
> +__v7m_proc_info:
> +	.long	0x000f0000		@ Required ID value
> +	.long	0x000f0000		@ Mask for ID
> +	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
> +	.long   0			@ proc_info_list.__cpu_io_mmu_flags
> +	b	__v7m_setup		@ proc_info_list.__cpu_flush
> +	.long	cpu_arch_name
> +	.long	cpu_elf_name
> +	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_IDIVT

Mainline is detecting HWCAP_IDIVT for v7 processors so you should be
able to leave that part out.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
