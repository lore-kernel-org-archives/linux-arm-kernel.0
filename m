From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 May 2015 15:05:46 +0200
Subject: [PATCH v2 4/5] ARM: dts: sun9i: Add A80 PRCM clocks and reset
 control nodes
In-Reply-To: <1430410206-4410-5-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
 <1430410206-4410-5-git-send-email-wens@csie.org>
Message-ID: <20150504130546.GC3274@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 12:10:05AM +0800, Chen-Yu Tsai wrote:
> This adds the PRCM clocks and reset controls to the A80 dtsi.
> 
> The list of apbs clock gates is incomplete. Tests show that bits 0~20
> are mutable. We will need documents from Allwinner to complete the
> support.
> 
> Also update clock and reset phandles for r_uart.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 64 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index d3dece2eea72..f0869ff8006f 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -169,6 +169,14 @@
>  					     "usb_phy2", "usb_hsic_12M";
>  		};
>  
> +		pll3: clk at 06000008 {
> +			/* placeholder until implemented */
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-rate = <0>;
> +			clock-output-names = "pll3";
> +		};
> +
>  		pll4: clk at 0600000c {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun9i-a80-pll4-clk";
> @@ -751,13 +759,67 @@
>  			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		prcm at 08001400 {
> +			compatible = "allwinner,sun9i-a80-prcm";
> +			reg = <0x08001400 0x200>;
> +
> +			cpus_clk: cpus_clk {

I wonder whether it would not be more readable to have this as
clk@<prcm_offset>, just like all the other clocks?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/193c9ca1/attachment.sig>
