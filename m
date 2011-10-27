From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 27 Oct 2011 13:10:10 -0700
Subject: [PATCH 4/6] arm/tegra: implement support for tegra30
In-Reply-To: <1319561644-6160-5-git-send-email-pdeschrijver@nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49B6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at  Tuesday, October 25, 2011 10:54 AM:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Some description here would be nice. And notes re: stuff like lack of
clock/... support yet, since this just gets stuff booted to a UART with
no clocks/devices/...

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig

> +config ARCH_TEGRA_3x_SOC
> +	bool "Enable support for Tegra30 family"
> +	select CPU_V7
> +	select ARM_GIC
> +	select ARCH_REQUIRE_GPIOLIB
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> +	select USB_ULPI if USB_SUPPORT
> +	select USB_ULPI_VIEWPORT if USB_SUPPORT
> +	select USE_OF
> +	help
> +	  Support for NVIDIA Tegra T30 processorfamily, based on the
> +	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller

Either remove "family" or add a space before it to separate the words.

-- 
nvpublic
