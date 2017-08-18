From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:02:16 +0200
Subject: [PATCH] arm64: dts: r8a7795-es1: Drop extra zero from usb unit
 address
In-Reply-To: <1502969354-14968-1-git-send-email-geert+renesas@glider.be>
References: <1502969354-14968-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170818080215.GG9175@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 01:29:14PM +0200, Geert Uytterhoeven wrote:
> With W=1:
> 
>     arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/usb at ee0400000 simple-bus unit address format error, expected "ee040000"
>     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/usb at ee0400000 simple-bus unit address format error, expected "ee040000"
> 
> Fixes: 291e0c4994d0813f ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
> Fixes: 171f2ef82284f61b ("arm64: dts: r8a7795: Add USB3.0 host device nodes")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The second fixes tag is for the original r8a7795.dtsi, before
> r8a7795-es1.dtsi was split off.

Do you want this treated as a fix for v4.13 or v4.14, or a regular patch
for v4.15? It looks like the problem has been present in some form since
v4.12.

> ---
>  arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> index aaa5e67a963ea9ff..655dd30639c55027 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> @@ -11,7 +11,7 @@
>  #include "r8a7795.dtsi"
>  
>  &soc {
> -	xhci1: usb at ee0400000 {
> +	xhci1: usb at ee040000 {
>  		compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
>  		reg = <0 0xee040000 0 0xc00>;
>  		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.7.4
> 
