From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 May 2018 09:59:27 -0300
Subject: [PATCH v2 4/4] ARM: dts: imx6dl-riotboard: fix OTG regulator
 polarity
In-Reply-To: <20180529062021.3154-5-akurz@blala.de>
References: <20180529062021.3154-1-akurz@blala.de>
 <20180529062021.3154-5-akurz@blala.de>
Message-ID: <CAOMZO5CORkXJ9zu8qRZm2JGvdPjJM1Gg40sgk7gox9Yh3gYYkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 3:20 AM, Alexander Kurz <akurz@blala.de> wrote:
> USB OTG power is switched on when the GPIO is pulled low.
>
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  arch/arm/boot/dts/imx6dl-riotboard.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
> index a6851bfebbdb..89b06e20480d 100644
> --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
> +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
> @@ -70,8 +70,7 @@
>                 regulator-name = "usb_otg_vbus";
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
> -               gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> +               gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
