From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Nov 2011 17:46:10 +0200
Subject: [PATCH v2 8/8] arm/tegra: add support for tegra30 based board
	cardhu
In-Reply-To: <1320242948-21061-9-git-send-email-pdeschrijver@nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111102154610.GJ13358@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 03:09:07PM +0100, Peter De Schrijver wrote:
> Add support for the tegra30 based cardhu development board. Cardhu is a tablet
> formfactor reference design for tegra30. The patch provides a device tree for
> the board, updates Makefile.boot to build the dtb, includes the platform in
> Kconfig and updates board-dt.c.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra-cardhu.dts |   36 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/Kconfig        |    7 +++++++
>  arch/arm/mach-tegra/Makefile.boot  |    1 +
>  arch/arm/mach-tegra/board-dt.c     |    1 +
>  4 files changed, 45 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra-cardhu.dts
> 
> diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
> new file mode 100644
> index 0000000..70c41fc
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra-cardhu.dts
> @@ -0,0 +1,36 @@
> +/dts-v1/;
> +
> +/include/ "tegra30.dtsi"
> +
> +/ {
> +	model = "NVIDIA Tegra30 Cardhu evaluation board";

And this should probably be removed.

> +	compatible = "nvidia,cardhu", "nvidia,tegra30";
> +
> +	memory {
> +		reg = < 0x80000000 0x40000000 >;
> +	};
> +
> +	serial at 70006000 {
> +		clock-frequency = < 408000000 >;
> +	};
> +
> +	i2c at 7000c000 {
> +		clock-frequency = <100000>;
> +	};
> +
> +	i2c at 7000c400 {
> +		clock-frequency = <100000>;
> +	};
> +
> +	i2c at 7000c500 {
> +		clock-frequency = <100000>;
> +	};
> +
> +	i2c at 7000c700 {
> +		clock-frequency = <100000>;
> +	};
> +
> +	i2c at 7000d000 {
> +		clock-frequency = <100000>;
> +	};
> +};
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index f2eb6d1..43a6352 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -83,6 +83,13 @@ config MACH_VENTANA
>         help
>           Support for the nVidia Ventana development platform
>  
> +config MACH_CARDHU
> +       bool "Cardhu board"
> +       depends on ARCH_TEGRA_3x_SOC
> +       select MACH_TEGRA_DT
> +       help
> +         Support for the nVidia Cardhu development platform

This should have been NVIDIA. Will be fixed in the next version. Most other
nvidia boards use 'nVidia' in their description. What should we do?

Cheers,

Peter.
