From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Nov 2018 10:39:04 +0100
Subject: [PATCH 08/15] ARM/arm64: sunxi: Move H3/H5 syscon label over to
 soc-specific nodes
In-Reply-To: <20181115145013.3378-9-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-9-paul.kocialkowski@bootlin.com>
Message-ID: <20181116093904.4ikn7ldksrm3mp5d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 03:50:06PM +0100, Paul Kocialkowski wrote:
> Now that we have specific nodes for the H3 and H5 system-controller
> that allow proper access to the EMAC clock configuration register,
> we no longer need a common dummy syscon node.
> 
> Switch the syscon label over to each platform's dtsi file.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi              | 2 +-
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 6 ------
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 7157d954fb8c..b337a9282783 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -134,7 +134,7 @@
>  	};
>  
>  	soc {
> -		system-control at 1c00000 {
> +		syscon: system-control at 1c00000 {
>  			compatible = "allwinner,sun8i-h3-system-control";
>  			reg = <0x01c00000 0x1000>;
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 4b1530ebe427..9175ff0fb59a 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -152,12 +152,6 @@
>  			};
>  		};
>  
> -		syscon: syscon at 1c00000 {
> -			compatible = "allwinner,sun8i-h3-system-controller",
> -				"syscon";
> -			reg = <0x01c00000 0x1000>;
> -		};
> -

You're also dropping the syscon compatible there. But I'm not sure how
it could work with the H3 EMAC driver that would overwrite the
compatible already.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/d8805931/attachment.sig>
