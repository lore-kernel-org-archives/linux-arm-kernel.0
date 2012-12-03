From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Mon, 3 Dec 2012 19:04:27 +0530
Subject: [PATCH v2 2/2] ARM: Exynos5250: Enabling ohci-exynos driver
In-Reply-To: <1352362881-14653-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iH20vwDit-=wk=HfPDArjr_Kuoj5AaVgTv_drjjz+23zQ@mail.gmail.com>
 <1352362881-14653-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAFp+6iEtGuPR5yKKEMeiiPHYVTa4Zv5P015uzccLMJDow8=B0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,


On Thu, Nov 8, 2012 at 1:51 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Adding OHCI device tree node for Exynos5250 along with
> the device base address.
>
Any thoughts about this please ?

> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |   15 +++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    6 ++++++
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 ++
>  4 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> index 833f5cf..5ff3def1 100644
> --- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -23,3 +23,18 @@ Example:
>                 interrupts = <0 71 0>;
>                 samsung,vbus-gpio = <&gpx2 6 1 3 3>;
>         };
> +
> +OHCI
> +Required properties:
> + - compatible: should be "samsung,exynos-ohci" for USB 2.0
> +   OHCI companion controller in host mode.
> + - reg: physical base address of the controller and length of memory mapped
> +   region.
> + - interrupts: interrupt number to the cpu.
> +
> +Example:
> +       usb at 12120000 {
> +               compatible = "samsung,exynos-ohci";
> +               reg = <0x12120000 0x100>;
> +               interrupts = <0 71 0>;
> +       };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 2995445..f18abe0 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -244,6 +244,12 @@
>                 interrupts = <0 71 0>;
>         };
>
> +       usb at 12120000 {
> +               compatible = "samsung,exynos-ohci";
> +               reg = <0x12120000 0x100>;
> +               interrupts = <0 71 0>;
> +       };
> +
>         amba {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 9a86b99..471ffaf 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -198,6 +198,7 @@
>  #define EXYNOS4_PA_OHCI                        0x12590000
>  #define EXYNOS4_PA_HSPHY               0x125B0000
>  #define EXYNOS5_PA_EHCI                        0x12110000
> +#define EXYNOS5_PA_OHCI                        0x12120000
>  #define EXYNOS4_PA_MFC                 0x13400000
>
>  #define EXYNOS4_PA_UART                        0x13800000
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index 89fa624..c03f3dd 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -88,6 +88,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>                                 "exynos5-mixer", NULL),
>         OF_DEV_AUXDATA("samsung,exynos-ehci", EXYNOS5_PA_EHCI,
>                                 "s5p-ehci", NULL),
> +       OF_DEV_AUXDATA("samsung,exynos-ohci", EXYNOS5_PA_OHCI,
> +                               "exynos-ohci", NULL),
>         {},
>  };
>
> --
> 1.7.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks & Regards
Vivek
