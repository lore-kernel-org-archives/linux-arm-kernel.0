From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Sep 2014 17:55:33 +0200
Subject: [PATCH v2 7/7] ARM: dts: sun6i: Add required ahb1 clock parent
 and rates for dma controller
In-Reply-To: <1411807795-6575-8-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-8-git-send-email-wens@csie.org>
Message-ID: <20140930155533.GP4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 04:49:55PM +0800, Chen-Yu Tsai wrote:
> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index caf879d..d7845d3 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -353,6 +353,11 @@
>  			clocks = <&ahb1_gates 6>;
>  			resets = <&ahb1_rst 6>;
>  			#dma-cells = <1>;
> +
> +			/* DMA controller requires AHB1 clocked from PLL6 */
> +			assigned-clocks = <&ahb1>;
> +			assigned-clock-parents = <&pll6 0>;
> +			assigned-clock-rates = <200000000>;

Again, I don't think we need the rate change, and that it's the right
place to put it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/68cbd249/attachment.sig>
