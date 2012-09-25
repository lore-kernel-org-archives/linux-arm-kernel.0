From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 14:23:08 +0800
Subject: [PATCH 2/2] ARM i.MX25: Add devicetree
In-Reply-To: <1348468841-4331-3-git-send-email-s.hauer@pengutronix.de>
References: <1348468841-4331-1-git-send-email-s.hauer@pengutronix.de>
 <1348468841-4331-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120925062306.GE27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 08:40:40AM +0200, Sascha Hauer wrote:
> This adds a i.MX25 dtsi file along with the i.MX25 clock tree
> documentation. The devicetree should be fairly complete for:
> 
> - uart
> - fec
> - i2c
> - spi
> - pwm
> - nand
> - gpio
> - wdog
> - esdhc
> - flexcan
> 
> The more exotic devices currently miss clock bindings.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

A couple of trivial comments below though.

<snip>

> +			i2c1: i2c at 43f80000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx25-i2c", "fsl,imx1-i2c";

When the series gets rebased on imx multi-platform branch, the property
needs to be:

				compatible = "fsl,imx25-i2c", "fsl,imx21-i2c";


> +				reg = <0x43f80000 0x4000>;
> +				clocks = <&clks 46>;
> +				clock-names = "";
> +				interrupts = <3>;
> +				status = "disabled";
> +			};

<snip>

> +		nand at bb000000 {

We can add a EMI node being parent of NAND to show how nand connects
to SoC.

Shawn

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			compatible = "fsl,imx25-nand";
> +			reg = <0xbb000000 0x2000>;
> +			interrupts = <33>;
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 1.7.10.4
> 
