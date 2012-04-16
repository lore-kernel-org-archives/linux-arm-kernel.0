From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 16 Apr 2012 10:45:00 -0700
Subject: [PATCH v3 2/6] ARM: local timers: Add A15 architected timer
 support
In-Reply-To: <1334592810-4382-3-git-send-email-marc.zyngier@arm.com>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
 <1334592810-4382-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F8C5A9C.9000506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/12 09:13, Marc Zyngier wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf006d4..68c382d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1543,6 +1543,13 @@ config HAVE_ARM_SCU
>  	help
>  	  This option enables support for the ARM system coherency unit
>  
> +config ARM_ARCH_TIMER
> +	bool "Architected timer support"
> +	depends on CPU_V7
> +	select TICK_ONESHOT

I believe TICK_ONESHOT is a "hidden" option that should not be selected
outside the generic clockevents layer. It seems Russell and Thomas have
talked about this too, see 3872c48 (tick: Document TICK_ONESHOT config
option, 2012-03-31).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
