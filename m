From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:50:56 +0200
Subject: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
In-Reply-To: <20180904044053.15425-9-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
Message-ID: <20180905075056.tob7itg3judccooe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:50PM +0800, Icenowy Zheng wrote:
> +		hdmi_phy: hdmi-phy at 1ef0000 {
> +			compatible = "allwinner,sun8i-h3-hdmi-phy";
> +			reg = <0x01ef0000 0x10000>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu 7>;
> +			clock-names = "bus", "mod", "pll-0";
> +			resets = <&ccu RST_BUS_HDMI0>;
> +			reset-names = "phy";
> +			#phy-cells = <0>;
> +		};

This needs to use the bindings we have for that phy.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/ee46ecd6/attachment.sig>
