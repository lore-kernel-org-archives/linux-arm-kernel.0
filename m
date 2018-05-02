From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 11:51:18 +0200
Subject: [PATCH net-next v2 15/15] arm64: dts: allwinner: a64: add SRAM
 controller device tree node
In-Reply-To: <20180501161227.2110-16-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
 <20180501161227.2110-16-wens@csie.org>
Message-ID: <20180502095118.rqnfwy576xh6ercm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 02, 2018 at 12:12:27AM +0800, Chen-Yu Tsai wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner A64 has a SRAM controller, and in the device tree currently
> we have a syscon node to enable EMAC driver to access the EMAC clock
> register. As SRAM controller driver can now export regmap for this
> register, replace the syscon node to the SRAM controller device node,
> and let EMAC driver to acquire its EMAC clock regmap.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..1c37659d9d41 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -168,10 +168,25 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		syscon: syscon at 1c00000 {
> -			compatible = "allwinner,sun50i-a64-system-controller",
> -				"syscon";
> +		sram_controller: sram-controller at 1c00000 {
> +			compatible = "allwinner,sun50i-a64-sram-controller";

I don't think there's anything preventing us from keeping the
-system-controller compatible. It's what was in the DT before, and
it's how it's called in the datasheet.

Otherwise, the whole serie looks good to me:
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/108aad0b/attachment.sig>
