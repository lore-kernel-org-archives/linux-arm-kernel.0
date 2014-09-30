From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Sep 2014 17:39:57 +0200
Subject: [PATCH v2 2/7] clk: sunxi: Implement A31 PLL6 as a divs clock
 for 2x output
In-Reply-To: <1411807795-6575-3-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-3-git-send-email-wens@csie.org>
Message-ID: <20140930153957.GM4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 27, 2014 at 04:49:50PM +0800, Chen-Yu Tsai wrote:
> Some clock modules on the A31 use PLL6x2 as one of their inputs.
> This patch changes the PLL6 implementation for A31 to a divs clock,
> i.e. clock with multiple outputs that have different dividers.
> The first output will be the normal PLL6 output, and the second
> will be PLL6x2.
> 
> This patch fixes the PLL6 N factor in the clock driver, and removes
> any /2 dividers in the PLL6 factors clock part. The N factor counts
> from 1 to 32, mapping to values 0 to 31, as shown in the A31 manual.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  5 ++--
>  drivers/clk/sunxi/clk-sunxi.c                     | 28 +++++++++++++----------
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index d3a5c3c..0d84f4b 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -59,8 +59,9 @@ Required properties for all clocks:
>  	multiplexed clocks, the list order must match the hardware
>  	programming order.
>  - #clock-cells : from common clock binding; shall be set to 0 except for
> -	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
> -	"allwinner,sun4i-pll6-clk" where it shall be set to 1
> +	the following compatibles where it shall be set to 1:
> +	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
> +	"allwinner,sun4i-pll6-clk", "allwinner, sun6i-a31-pll6-clk"
                                               ^ Drop this extra space

And you're still not documenting what outputs you might have on pll6,
and what the extra argument correspond to.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/c1ff84f6/attachment.sig>
