From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 21:07:52 +0800
Subject: [PATCH] arm/imx6q: Rename Sabreauto to Armadillo2
In-Reply-To: <1323244235-17127-1-git-send-email-dirk.behme@de.bosch.com>
References: <1323244235-17127-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20111207130750.GP5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 08:50:35AM +0100, Dirk Behme wrote:
> The Sabreauto board was renamed to Armadillo2 recently. To avoid
> confusion, rename Sabreauto to Armadillo2/arm2.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt      |    4 ++--
>  .../dts/{imx6q-sabreauto.dts => imx6q-arm2.dts}    |    4 ++--
>  arch/arm/mach-imx/mach-imx6q.c                     |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-arm2.dts} (91%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index c9848ad..1b81e99 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -21,6 +21,6 @@ i.MX53 Smart Mobile Reference Design Board
>  Required root node properties:
>      - compatible = "fsl,imx53-smd", "fsl,imx53";
>  
> -i.MX6 Quad SABRE Automotive Board
> +i.MX6 Quad Armadillo2 Board
>  Required root node properties:
> -    - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> +    - compatible = "fsl,imx6q-arm2", "fsl,imx6q";
> diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> similarity index 91%
> rename from arch/arm/boot/dts/imx6q-sabreauto.dts
> rename to arch/arm/boot/dts/imx6q-arm2.dts
> index 072974e..b078b91 100644
> --- a/arch/arm/boot/dts/imx6q-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -14,8 +14,8 @@
>  /include/ "imx6q.dtsi"
>  
>  / {
> -	model = "Freescale i.MX6 Quad SABRE Automotive Board";
> -	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> +	model = "Freescale i.MX6 Quad Armadillo2 Board";
> +	compatible = "fsl,imx6q-arm2", "fsl,imx6q";
>  
>  	chosen {
>  		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk3p3 rootwait";
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index cf9a364..ce65375 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -75,7 +75,7 @@ static struct sys_timer imx6q_timer = {
>  };
>  
>  static const char *imx6q_dt_compat[] __initdata = {
> -	"fsl,imx6q-sabreauto",
> +	"fsl,imx6q-arm2",
>  	"fsl,imx6q-sabrelite",

Mainline kernel does not have this sabrelite yet.  That said you need
to create the patch against the mainline kernel (the latest -rc).

Regards,
Shawn

>  	NULL,
>  };
> -- 
> 1.7.0.4
