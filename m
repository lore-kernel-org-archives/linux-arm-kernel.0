From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 27 Oct 2011 13:22:04 -0700
Subject: [PATCH 6/6] arm/tegra: add support for tegra30 based board cardhu
In-Reply-To: <1319561644-6160-7-git-send-email-pdeschrijver@nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-7-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49C9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Some description of what Cardhu is and what's done in the patch please.

> diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
> new file mode 100644
> index 0000000..0f3f8a8
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra-cardhu.dts
> @@ -0,0 +1,37 @@
> +/dts-v1/;
> +
> +/include/ "tegra30.dtsi"
> +
> +/ {
> +	model = "NVIDIA Tegra30 Cardhu evaluation board";
> +	compatible = "nvidia,cardhu", "nvidia,tegra30";
> +
> +	memory {
> +		device_type = "memory";

The other boards don't contain this. If they should, can you please post
a patch to add it to them all? Thanks.

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 21c99f9..3ff191a 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -83,6 +83,12 @@ config MACH_VENTANA
>         help
>           Support for the nVidia Ventana development platform
> 
> +config MACH_CARDHU
> +       bool "Cardhu board"
> +       select MACH_TEGRA_DT
> +       help
> +         Support for the nVidia Cardhu development platform

This should depend on Tegra30 support.

Please use the capitalization NVIDIA; we should do a pass and clean up
any existing instances sometime.

-- 
nvpublic
