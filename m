From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 08:59:01 -0500
Subject: [PATCH 08/10] ARM: sunxi: dt: Update interrupt controller
 compatible string
In-Reply-To: <1364218233-29636-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364218233-29636-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51505825.2060805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 08:30 AM, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |    2 +-
>  arch/arm/boot/dts/sun5i-a13.dtsi |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index be71782..805d704 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -121,7 +121,7 @@
>  		ranges;
>  
>  		intc: interrupt-controller at 01c20400 {
> -			compatible = "allwinner,sunxi-ic";
> +			compatible = "allwinner,sun4i-ic";

Generally speaking, this is a bad thing to do. This breaks compatibility
between dtb and kernel versions. If that breakage is not yet a concern
for sunxi, then it is okay.

Also, I don't see any documentation updates for any of these changes.

Rob

>  			reg = <0x01c20400 0x400>;
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index 7a81aaf..760222c 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -122,7 +122,7 @@
>  		ranges;
>  
>  		intc: interrupt-controller at 01c20400 {
> -			compatible = "allwinner,sunxi-ic";
> +			compatible = "allwinner,sun4i-ic";
>  			reg = <0x01c20400 0x400>;
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> 
