From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 16:20:34 +0100
Subject: [PATCH v7 3/4] arm64: dts: marvell: Add I2C definitions for the
 Armada 3700
In-Reply-To: <20161201110440.27530-4-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 1 Dec 2016 12:04:39 +0100")
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-4-romain.perier@free-electrons.com>
Message-ID: <8760lwgofx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On jeu., d?c. 01 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> The Armada 3700 has two i2c bus interface units, this commit adds the
> definitions of the corresponding device nodes. It also enables the node
> on the development board for this SoC.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts |  4 ++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 1372e9a6..16d84af 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -62,6 +62,10 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +};
> +
>  /* CON3 */
>  &sata {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index e9bd587..1b0fd21 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -98,6 +98,24 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			i2c0: i2c at 11000 {
> +				compatible = "marvell,armada-3700-i2c";
> +				reg = <0x11000 0x24>;
> +				clocks = <&nb_periph_clk 10>;
> +				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +				mrvl,i2c-fast-mode;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 11080 {
> +				compatible = "marvell,armada-3700-i2c";
> +				reg = <0x11080 0x24>;
> +				clocks = <&nb_periph_clk 9>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				mrvl,i2c-fast-mode;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial at 12000 {
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x400>;
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
