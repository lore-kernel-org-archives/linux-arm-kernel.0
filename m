From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Fri, 21 Dec 2012 17:02:08 +0100
Subject: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
In-Reply-To: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Thanks  for the patch.

2012/12/20 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>:
> IGEP v2 boards has console as ttyO2,115200n8.
> It's better so simply set this as the default kernel argument
> directly in the device tree board file.
>
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/omap3-igep0020.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index e2b9849..45ffe21 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -15,6 +15,10 @@
>         model = "IGEPv2";
>         compatible = "isee,omap3-igep0020", "ti,omap3";
>
> +       chosen {
> +               bootargs = "console=ttyO2,115200n8 earlyprintk";
> +       };
> +

The u-boot 'bootargs' env overwrites the one from chosen ?

>         leds {
>                 compatible = "gpio-leds";
>                 boot {
> --
> 1.7.8.6
>
