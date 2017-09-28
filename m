From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Sep 2017 17:11:03 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun8i: Add basic dtsi file for
 Allwinner R40
In-Reply-To: <20170928092543.45648-2-icenowy@aosc.io>
References: <20170928092543.45648-1-icenowy@aosc.io>
 <20170928092543.45648-2-icenowy@aosc.io>
Message-ID: <20170928151103.ov3o5pn5h7inzzan@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 28, 2017 at 09:25:41AM +0000, Icenowy Zheng wrote:
> +		/*
> +		 * The max-frequency properties in all MMC controller nodes
> +		 * are conservative values proven to work on Banana Pi M2
> +		 * Ultra (the first community available R40 board).
> +		 * As the board doesn't wire MMC3 out, the property is not
> +		 * set in MMC3.
> +		 * TODO: measure the accurate max frequency of the controllers.
> +		 */
> +		mmc0: mmc at 1c0f000 {
> +			compatible = "allwinner,sun8i-r40-mmc",
> +				     "allwinner,sun50i-a64-mmc";
> +			reg = <0x01c0f000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			pinctrl-0 = <&mmc0_pins>;
> +			pinctrl-names = "default";
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <25000000>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};

Sorry if it wasn't really clear, but my point was more than you should
just drop the max-frequency property

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/158286a3/attachment.sig>
