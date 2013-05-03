From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 May 2013 19:04:34 +0200
Subject: [PATCH v2] ARM: dts: Add SPI support for i.MX27 Phytec PCM038
 module
In-Reply-To: <1367568501-29467-1-git-send-email-shc_work@mail.ru>
References: <1367568501-29467-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130503170434.GV32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 12:08:21PM +0400, Alexander Shiyan wrote:
> Added SPI node and PMIC MC13783 (spi0.0) to imx27-phytec-phycore DT file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dts | 109 +++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> index fe64e3a..eb7d9fa 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> @@ -72,6 +72,115 @@
>  	};
>  };
>  
> +&cspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio4 28 0>;
> +	status = "okay";
> +
> +	pmic: mc13783 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,mc13783";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <23 0x4>;
> +		fsl,mc13xxx-uses-adc;
> +		fsl,mc13xxx-uses-rtc;
> +
> +		regulators {
> +			sw1a_reg: sw1a {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			sw1b_reg: sw1b {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			sw2a_reg: sw2a {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			sw2b_reg: sw2b {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			sw3_reg: sw3 {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vaudio_reg: vaudio {
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			violo_reg: violo {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			viohi_reg: viohi {
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vgen_reg: vgen {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vcam_reg: vcam {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			vrf1_reg: vrf1 {
> +				regulator-min-microvolt = <2775000>;
> +				regulator-max-microvolt = <2775000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vrf2_reg: vrf2 {
> +				regulator-min-microvolt = <2775000>;
> +				regulator-max-microvolt = <2775000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vmmc1_reg: vmmc1 {
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			gpo1_reg: gpo1 { };
> +
> +			pwgt1spi_reg: pwgt1spi {
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
>  &nfc {
>  	nand-bus-width = <8>;
>  	nand-ecc-mode = "hw";
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
