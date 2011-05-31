From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 31 May 2011 01:04:16 -0700
Subject: [RFC PATCH v5 13/13] ARM: SMP: automatically select ARM_GIC_VPPI
In-Reply-To: <1306749894-28749-14-git-send-email-marc.zyngier@arm.com>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
	<1306749894-28749-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DE4A100.8020009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2011 3:04 AM, Marc Zyngier wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..60942681 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1313,6 +1313,7 @@ config SMP
>  		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
>  		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
>  	select USE_GENERIC_SMP_HELPERS
> +	select ARM_GIC_VPPI
>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP

Would it be better to select GIC_VPPI only if GIC is selected as well? So

    select ARM_GIC_VPPI if ARM_GIC

Or put this select under ARM_GIC and have it be

    select ARM_GIC_VPPI if SMP

?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
