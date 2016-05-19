From: kristofer.s.martinez@gmail.com (Martinez Kristofer)
Date: Thu, 19 May 2016 17:58:36 +0800
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add DT node for TI PCA9536
In-Reply-To: <1463640450-16762-3-git-send-email-vigneshr@ti.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
 <1463640450-16762-3-git-send-email-vigneshr@ti.com>
Message-ID: <CABtop_EjYF+8i4=GTLWyKGO3CMm9o3Qgv104ZrOJYyExAwDuoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 2:47 PM, Vignesh R <vigneshr@ti.com> wrote:
> AM335x ICE board has a TI PCA9536 chip connected to I2C0 at address
> 0x41. Add DT entry for the same.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm/boot/dts/am335x-icev2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
> index e271013e78a6..7d8b8fefdf08 100644
> --- a/arch/arm/boot/dts/am335x-icev2.dts
> +++ b/arch/arm/boot/dts/am335x-icev2.dts
> @@ -206,6 +206,13 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
>         };
> +
> +       pca9536: gpio at 41 {
> +               compatible = "ti,pca9536";
> +               reg = <0x41>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
>  };
>
>  #include "tps65910.dtsi"

Acked-by: Kristofer Martinez <Kristofer.S.Martinez@gmail.com>

M.K.

> --
> 2.8.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
