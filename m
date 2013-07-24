From: tobetter@gmail.com (Dongjin Kim)
Date: Wed, 24 Jul 2013 23:17:23 +0900
Subject: [PATCH 1/2] ARM: dts: Add USB Host nodes to Exynos4210
In-Reply-To: <000101ce5c51$887309f0$99591dd0$@samsung.com>
References: <000101ce5c51$887309f0$99591dd0$@samsung.com>
Message-ID: <CADoNuNeax8N1TNRN66-k1fnxxpZCPRUH4Me2VehSDfJzfyq+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

I had submitted another patch almost similar contents, but my patch
contains both EHCI and OHCI USB host devices node in exynos4.dtsi
since I had tested on Exynos4412 and their register map are same with
Exynos4210.

[1] https://patchwork.kernel.org/patch/2832779

On Wed, May 29, 2013 at 6:47 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> Add device nodes for USB Host EHCI and OHCI controllers to Exynos4210.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos4210.
>
>  arch/arm/boot/dts/exynos4210.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 366795a..3c173c7 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -117,6 +117,24 @@
>                 status = "disabled";
>         };
>
> +       usb at 12580000 {
> +               compatible = "samsung,exynos4210-ehci";
> +               reg = <0x12580000 0x100>;
> +               interrupts = <0 70 0>;
> +
> +               clocks = <&clock 304>;
> +               clock-names = "usbhost";
> +       };
> +
> +       usb at 12590000 {
> +               compatible = "samsung,exynos4210-ohci";
> +               reg = <0x12590000 0x100>;
> +               interrupts = <0 70 0>;
> +
> +               clocks = <&clock 304>;
> +               clock-names = "usbhost";
> +       };
> +
>         g2d at 12800000 {
>                 compatible = "samsung,s5pv210-g2d";
>                 reg = <0x12800000 0x1000>;
> --
> 1.7.10.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
