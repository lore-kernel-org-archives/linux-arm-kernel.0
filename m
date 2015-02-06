From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Feb 2015 11:57:58 -0800
Subject: [PATCH 08/10] ARM: mvebu: add core support for Armada 39x
In-Reply-To: <1423238276-9206-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54D51CC6.2070908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/15 07:57, Thomas Petazzoni wrote:
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 89a139e..d88438f 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -232,3 +232,17 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
>  	.restart	= mvebu_restart,
>  	.dt_compat	= armada_38x_dt_compat,
>  MACHINE_END
> +
> +static const char * const armada_39x_dt_compat[] = {

 __initconst?

> +	"marvell,armada390",
> +	"marvell,armada398",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(ARMADA_39X_DT, "Marvell Armada 39x (Device Tree)")
> +	.l2c_aux_val	= 0,
> +	.l2c_aux_mask	= ~0,
> +	.init_irq       = mvebu_init_irq,
> +	.restart	= mvebu_restart,
> +	.dt_compat	= armada_39x_dt_compat,
> +MACHINE_END
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
