From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 4 Nov 2011 13:43:57 -0700
Subject: [PATCH v2 7/8] arm/tegra: implement support for tegra30
In-Reply-To: <1320242948-21061-8-git-send-email-pdeschrijver@nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-8-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4E4F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, November 02, 2011 8:09 AM:
> Add support for tegra30 SoC. This includes a device tree compatible type for
> this SoC ("nvidia,tegra30") and adds L2 cache initialization for this new SoC.
> The clock framework is still missing, which prevents most drivers from working.
...
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
...
> @@ -17,7 +14,18 @@ config ARCH_TEGRA_2x_SOC
>  	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
>  	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
> 
> -endchoice
> +config ARCH_TEGRA_3x_SOC

Wasn't that config option already used earlier in the series, e.g. in
[PATCH v2 6/8] arm/tegra: pinmux tables and definitions for tegra30.
Should this patch be pushed earlier so it isn't used before it's created?
I'm not sure how much that matters.

-- 
nvpublic
