From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jun 2017 11:42:41 +0200
Subject: [PATCH v2 10/11] ARM: sun8i: h3: add display engine pipeline for
 TVE
In-Reply-To: <20170604160149.30230-11-icenowy@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-11-icenowy@aosc.io>
Message-ID: <20170607094241.65dcm42aacrn4eev@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 12:01:48AM +0800, Icenowy Zheng wrote:
> +	soc {
> +		display_clocks: clock at 1000000 {
> +			compatible = "allwinner,sun8i-a83t-de2-clk";
> +			reg = <0x01000000 0x100000>;
> +			clocks = <&ccu CLK_BUS_DE>,
> +				 <&ccu CLK_DE>;
> +			clock-names = "bus",
> +				      "mod";
> +			resets = <&ccu RST_BUS_DE>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			assigned-clocks = <&ccu CLK_DE>;
> +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
> +			assigned-clock-rates = <432000000>;
> +		};

We discussed that already a few times, but there's no reason to do
so. If you need a downstream clock at a particular rate, call
clk_set_rate on it, period.

Whether its parent will be coming from PLL_DE or some other more
appriopriate clock is not relevant and doesn't make any difference.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/5effff3b/attachment.sig>
