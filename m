From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 31 Aug 2016 07:18:47 +0000
Subject: [PATCH v2 5/6] ARM: tegra: Add Tegra20 GMI support
References: <1472569349.5703.25.camel@toradex.com>
Message-ID: <1472627926.31008.7.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
> 
> From: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add a device node for the GMI controller found on Tegra20.
> 
> Signed-off-by: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.g
> mane.org>
> ---
> Changes in v2:
> - added address-cells, size-cells and ranges properties
> 
> ?arch/arm/boot/dts/tegra20.dtsi | 14 ++++++++++++++
> ?1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi
> b/arch/arm/boot/dts/tegra20.dtsi
> index 2207c08..03eb029 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -376,6 +376,20 @@
> ?		status = "disabled";
> ?	};
> 
> +
> +	gmi at 70009000 {
> +		compatible = "nvidia,tegra20-gmi";
> +		reg = <70009000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x48000000 0x7ffffff>;

On T20 it is actually rather 0xd0000000.

> 
> +		clocks = <&tegra_car TEGRA20_CLK_NOR>;
> +		clock-names = "gmi";
> +		resets = < &tegra_car 42>;
> +		reset-names = "gmi";
> +		status = "disabled";
> +	};
> +
> ?	pwm: pwm at 7000a000 {
> ?		compatible = "nvidia,tegra20-pwm";
> ?		reg = <0x7000a000 0x100>;
> --
> 2.1.4
