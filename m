From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 11 Nov 2011 14:02:49 -0800
Subject: [PATCH v4 09/10] arm/tegra: implement support for tegra30
In-Reply-To: <1321010541-31337-10-git-send-email-pdeschrijver@nvidia.com>
References: <1321010541-31337-1-git-send-email-pdeschrijver@nvidia.com>
 <1321010541-31337-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17408058CA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Friday, November 11, 2011 4:22 AM:
> Add support for tegra30 SoC. This includes a device tree compatible type for
> this SoC ("nvidia,tegra30") and adds L2 cache initialization for this new SoC.
> The clock framework is still missing, which prevents most drivers from working.
> The basic IRQs are the same, so remove the dependency on
> CONFIG_ARCH_TEGRA_2x_SOC.

> diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h

>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  void __init tegra20_init_early(void);
>  #endif
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +void __init tegra30_init_early(void);
> +#endif

Do we need to ifdef the prototypes? Same comment for Tegra30 here and
Tegra20 in the earlier patch.

-- 
nvpublic
