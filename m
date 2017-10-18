From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Oct 2017 15:12:33 -0500
Subject: [PATCH v2 1/6] ARM: dts: imx51-apf51dev: Fix 'backlight@bl1' node
 with unit name and no reg property
In-Reply-To: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAL_JsqJZD+DTe9-sAX+MbHr2ZZz3riXQ7nFcy5OmADK+a2F9SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 2:29 PM, Marco Franchi <marco.franchi@nxp.com> wrote:
> The following build warning is seen with W=1:
>
> Warning (unit_address_vs_reg): Node /backlight at bl1 has a unit name, but no
> reg property
>
> Fix this warning by changing '@' to '-'.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> ---
> Changes since v1:
> -none
>  arch/arm/boot/dts/imx51-apf51dev.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
> index 2f1a9d2..a6c2c11 100644
> --- a/arch/arm/boot/dts/imx51-apf51dev.dts
> +++ b/arch/arm/boot/dts/imx51-apf51dev.dts
> @@ -16,7 +16,7 @@
>         model = "Armadeus Systems APF51Dev docking/development board";
>         compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
>
> -       backlight at bl1{
> +       backlight-bl1{

Is there more that one? If not, just "backlight".

You also should have a space before the {.

>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_backlight>;
>                 compatible = "gpio-backlight";
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
