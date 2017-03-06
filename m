From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Mar 2017 12:12:18 +0800
Subject: [linux-sunxi] [PATCH v2 08/12] ARM: dts: sun8i: restore the
 inclusion of ccu headers in V3s DTSI
In-Reply-To: <20170305133709.6288-9-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
 <20170305133709.6288-9-icenowy@aosc.xyz>
Message-ID: <CAGb2v65uPa3ZNmvCfDqoj6o0MfxTij3jJZhDyHJE=WpE4s6OYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 5, 2017 at 9:37 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> When the V3s support patchset is applied, CCU headers and V3s DTSI went
> into different trees, so the CCU inclusion is removed in the DTSI.
>
> Add back them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 67 ++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 71075969e5e6..b3f8b7f9c0bb 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -40,6 +40,8 @@
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
> +#include <dt-bindings/clock/sun8i-v3s-ccu.h>
> +#include <dt-bindings/reset/sun8i-v3s-ccu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>

Please sort alphabetically. Or if you want, put the sunxi specific headers
in a separate group, separated by an empty line from the arm-gic one.

>
>  / {
> @@ -55,7 +57,7 @@
>                         compatible = "arm,cortex-a7";
>                         device_type = "cpu";
>                         reg = <0>;
> -                       clocks = <&ccu 14>;
> +                       clocks = <&ccu CLK_CPU>;
>                 };
>         };
>
> @@ -96,15 +98,15 @@
>                 mmc0: mmc at 01c0f000 {
>                         compatible = "allwinner,sun7i-a20-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ccu 22>,
> -                                <&ccu 45>,
> -                                <&ccu 47>,
> -                                <&ccu 46>;
> +                       clocks = <&ccu CLK_BUS_MMC0>,
> +                                <&ccu CLK_MMC0>,
> +                                <&ccu CLK_MMC0_OUTPUT>,
> +                                <&ccu CLK_MMC0_SAMPLE>;
>                         clock-names = "ahb",
>                                       "mmc",
>                                       "output",
>                                       "sample";
> -                       resets = <&ccu 7>;
> +                       resets = <&ccu RST_BUS_MMC0>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
> @@ -115,15 +117,15 @@
>                 mmc1: mmc at 01c10000 {
>                         compatible = "allwinner,sun7i-a20-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ccu 23>,
> -                                <&ccu 48>,
> -                                <&ccu 50>,
> -                                <&ccu 49>;
> +                       clocks = <&ccu CLK_BUS_MMC1>,
> +                                <&ccu CLK_MMC1>,
> +                                <&ccu CLK_MMC1_OUTPUT>,
> +                                <&ccu CLK_MMC1_SAMPLE>;
>                         clock-names = "ahb",
>                                       "mmc",
>                                       "output",
>                                       "sample";
> -                       resets = <&ccu 8>;
> +                       resets = <&ccu RST_BUS_MMC1>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
> @@ -134,15 +136,15 @@
>                 mmc2: mmc at 01c11000 {
>                         compatible = "allwinner,sun7i-a20-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ccu 24>,
> -                                <&ccu 51>,
> -                                <&ccu 53>,
> -                                <&ccu 52>;
> +                       clocks = <&ccu CLK_BUS_MMC2>,
> +                                <&ccu CLK_MMC2>,
> +                                <&ccu CLK_MMC2_OUTPUT>,
> +                                <&ccu CLK_MMC2_SAMPLE>;
>                         clock-names = "ahb",
>                                       "mmc",
>                                       "output",
>                                       "sample";
> -                       resets = <&ccu 9>;
> +                       resets = <&ccu RST_BUS_MMC2>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
> @@ -153,8 +155,8 @@
>                 usb_otg: usb at 01c19000 {
>                         compatible = "allwinner,sun8i-h3-musb";
>                         reg = <0x01c19000 0x0400>;
> -                       clocks = <&ccu 29>;
> -                       resets = <&ccu 17>;
> +                       clocks = <&ccu CLK_BUS_OTG>;
> +                       resets = <&ccu RST_BUS_OTG>;
>                         interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "mc";
>                         phys = <&usbphy 0>;
> @@ -169,9 +171,9 @@
>                               <0x01c1a800 0x4>;
>                         reg-names = "phy_ctrl",
>                                     "pmu0";
> -                       clocks = <&ccu 56>;
> +                       clocks = <&ccu CLK_USB_PHY0>;
>                         clock-names = "usb0_phy";
> -                       resets = <&ccu 0>;
> +                       resets = <&ccu RST_USB_PHY0>;
>                         reset-names = "usb0_reset";
>                         status = "disabled";
>                         #phy-cells = <1>;
> @@ -198,7 +200,7 @@
>                         reg = <0x01c20800 0x400>;
>                         interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
> +                       clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
>                         clock-names = "apb", "hosc", "losc";
>                         gpio-controller;
>                         #gpio-cells = <3>;
> @@ -213,6 +215,7 @@
>                         uart0_pins_a: uart0 at 0 {
>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
> +                               bias-pull-up;

This is an unrelated change. Please split it out. On the other hand,
if the board has proper external pull-ups, you might not need this.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>                         };
>
>                         mmc0_pins_a: mmc0 at 0 {
> @@ -244,8 +247,8 @@
>                         interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>                         reg-shift = <2>;
>                         reg-io-width = <4>;
> -                       clocks = <&ccu 40>;
> -                       resets = <&ccu 49>;
> +                       clocks = <&ccu CLK_BUS_UART0>;
> +                       resets = <&ccu RST_BUS_UART0>;
>                         status = "disabled";
>                 };
>
> @@ -255,8 +258,8 @@
>                         interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>                         reg-shift = <2>;
>                         reg-io-width = <4>;
> -                       clocks = <&ccu 41>;
> -                       resets = <&ccu 50>;
> +                       clocks = <&ccu CLK_BUS_UART1>;
> +                       resets = <&ccu RST_BUS_UART1>;
>                         status = "disabled";
>                 };
>
> @@ -266,8 +269,8 @@
>                         interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>                         reg-shift = <2>;
>                         reg-io-width = <4>;
> -                       clocks = <&ccu 42>;
> -                       resets = <&ccu 51>;
> +                       clocks = <&ccu CLK_BUS_UART2>;
> +                       resets = <&ccu RST_BUS_UART2>;
>                         status = "disabled";
>                 };
>
> @@ -275,10 +278,8 @@
>                         compatible = "allwinner,sun6i-a31-i2c";
>                         reg = <0x01c2ac00 0x400>;
>                         interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&ccu 38>;
> -                       resets = <&ccu 46>;
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&i2c0_pins>;
> +                       clocks = <&ccu CLK_BUS_I2C0>;
> +                       resets = <&ccu RST_BUS_I2C0>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -288,8 +289,8 @@
>                         compatible = "allwinner,sun6i-a31-i2c";
>                         reg = <0x01c2b000 0x400>;
>                         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&ccu 39>;
> -                       resets = <&ccu 47>;
> +                       clocks = <&ccu CLK_BUS_I2C1>;
> +                       resets = <&ccu RST_BUS_I2C1>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.11.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
