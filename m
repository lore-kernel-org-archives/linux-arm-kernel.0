From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 16:57:53 +0100
Subject: [PATCH 3/5] ARM: sun6i: dt: Add A31 GMAC gigabit ethernet
 controller node
In-Reply-To: <1394036835-22007-4-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
 <1394036835-22007-4-git-send-email-wens@csie.org>
Message-ID: <20140317155753.GN27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 12:27:13AM +0800, Chen-Yu Tsai wrote:
> The A31 has the same GMAC found on the A20 SoC, except it has
> an extra reset control.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index ee09e4c..e958d5f 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -429,6 +429,22 @@
>  			status = "disabled";
>  		};
>  
> +		gmac: ethernet at 01c30000 {
> +			compatible = "allwinner,sun7i-a20-gmac";
> +			reg = <0x01c30000 0x1054>;
> +			interrupts = <0 82 4>;
> +			interrupt-names = "macirq";
> +			clocks = <&ahb1_gates 17>, <&gmac_tx_clk>;
> +			clock-names = "stmmaceth", "allwinner_gmac_tx";
> +			resets = <&ahb1_rst 17>;

You need an additional
			reset-names = "stmmaceth";

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/c91eb138/attachment.sig>
