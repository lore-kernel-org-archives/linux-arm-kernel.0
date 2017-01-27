From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 16:58:51 +0100
Subject: [PATCH v2 6/9] arm64: dts: allwinner: add Allwinner H5 .dtsi
In-Reply-To: <20170126154859.55855-7-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-7-icenowy@aosc.xyz>
Message-ID: <20170127155851.lv64kh7gm4ztsjpg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:56PM +0800, Icenowy Zheng wrote:
> +		mmc at 01c0f000 {

Please use a label based syntax here too.

> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";

The compatibility with the A13 has never been true, and the compatible
should be "allwinner,sun50i-h5-mmc", "allwinner,sun50i-a64-mmc".

> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		mmc at 01c10000 {
> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";
> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		mmc at 01c11000 {
> +			compatible = "allwinner,sun50i-a64-mmc",

And this is very likely to use the emmc compatible.

> +				     "allwinner,sun5i-a13-mmc";
> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names = "ahb", "mmc";
> +		};
> +
> +		clock at 01c20000 {
> +			compatible = "allwinner,sun50i-h5-ccu",
> +				     "allwinner,sun8i-h3-ccu";
> +		};

If it doesn't have the same clocks, it's not compatible with the H3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/c94c221b/attachment-0001.sig>
