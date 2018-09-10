From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 10 Sep 2018 16:23:54 +0200
Subject: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback
 compatible from R40 DT
In-Reply-To: <20180907072234.48282-6-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-6-icenowy@aosc.io>
Message-ID: <20180910142354.5ldexkvnan6ohz4x@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> The R40 HDMI PHY seems to be different to the A64 one, the A64 one
> has no input mux, but the R40 one has.
> 
> Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index ffd9f00f74a4..5f547c161baf 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -800,8 +800,7 @@
>  		};
>  
>  		hdmi_phy: hdmi-phy at 1ef0000 {
> -			compatible = "allwinner,sun8i-r40-hdmi-phy",
> -				     "allwinner,sun50i-a64-hdmi-phy";
> +			compatible = "allwinner,sun8i-r40-hdmi-phy";

If you could use the A64 phy before, you can still use it now.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/cb6a35e8/attachment.sig>
