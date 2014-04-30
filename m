From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 30 Apr 2014 22:15:19 +0530
Subject: [PATCH 4/4] ARM: dts: Add usb 2.0 support on exynos5420
In-Reply-To: <1398848110-6152-5-git-send-email-gautam.vivek@samsung.com>
References: <1398848110-6152-1-git-send-email-gautam.vivek@samsung.com>
 <1398848110-6152-5-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAK9yfHzxLei60hFQges6Vk0nzRUjLDdC3io8FHrT0zkuU65vgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 April 2014 14:25, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Add required device node for ehci and ohci controllers to
> enable USB 2.0 support.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 16b860a..392d340 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -738,7 +738,41 @@
>                 samsung,power-domain = <&g2d_pd>;
>         };
>
> -       phy at 12130000 {
> +       usb at 12110000 {
> +               compatible = "samsung,exynos4210-ehci";
> +               reg = <0x12110000 0x100>;
> +               interrupts = <0 71 0>;
> +
> +               clocks = <&clock CLK_USBH20>;
> +               clock-names = "usbhost";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port at 0 {
> +                       reg = <0>;
> +                       phys = <&usb2_phy_gen 1>;
> +                       phy-names = "host";
> +                       status = "ok";
s/ok/okay

> +               };
> +       };
> +
> +       usb at 12120000 {
> +               compatible = "samsung,exynos4210-ohci";
> +               reg = <0x12120000 0x100>;
> +               interrupts = <0 71 0>;
> +
> +               clocks = <&clock CLK_USBH20>;
> +               clock-names = "usbhost";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port at 0 {
> +                       reg = <0>;
> +                       phys = <&usb2_phy_gen 1>;
> +                       phy-names = "host";
> +                       status = "ok";

ditto

-- 
With warm regards,
Sachin
