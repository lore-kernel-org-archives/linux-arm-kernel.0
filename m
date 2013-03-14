From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Thu, 14 Mar 2013 11:52:51 +0530
Subject: [PATCH] ARM: dts: add usb 2.0 clock references to exynos5250
 device tree
In-Reply-To: <1363195099-15919-1-git-send-email-dianders@chromium.org>
References: <1363195099-15919-1-git-send-email-dianders@chromium.org>
Message-ID: <CAFp+6iEV+C_nGtMhCUQX-M4T3Ac2i8QeAhkGC1wxrCBTAJrNYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,


On Wed, Mar 13, 2013 at 10:48 PM, Doug Anderson <dianders@chromium.org> wrote:
> This is a fixup to two device tree nodes that have already landed but
> without clock nodes since the transition to common clock happened at
> the same time.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 24c52e6..59be603 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -402,12 +402,18 @@
>                 compatible = "samsung,exynos4210-ehci";
>                 reg = <0x12110000 0x100>;
>                 interrupts = <0 71 0>;
> +
> +               clocks = <&clock 285>;
> +               clock-names = "usbhost";
>         };
>
>         usb at 12120000 {
>                 compatible = "samsung,exynos4210-ohci";
>                 reg = <0x12120000 0x100>;
>                 interrupts = <0 71 0>;
> +
> +               clocks = <&clock 285>;
> +               clock-names = "usbhost";

It will be nice if you can please update relevant information
alongwith this, in the bindings doc for "exynos-usb".

>         };
>
>         amba {
> --
> 1.8.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks & Regards
Vivek
