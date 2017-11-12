From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 12 Nov 2017 02:33:48 +0100
Subject: [PATCH v4 4/4] ARM64: dts: meson: drop "sana" clock from SAR ADC
In-Reply-To: <20171107141027.30717-1-yixun.lan@amlogic.com>
References: <20171107141027.30717-1-yixun.lan@amlogic.com>
Message-ID: <CAFBinCAEgCzZQQN4V8bJMpkNJ9AJLDLWC2DSEkz7N7m60p=QDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On Tue, Nov 7, 2017 at 3:10 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> The SAR ADC modules doesn't require The "sana" clock.
>
> Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi               | 5 ++---
>  arch/arm/boot/dts/meson8b.dtsi              | 5 ++---
these two should go into a separate patch (with "ARM: dts: ..."
prefix) - the ARM maintainers want separate pull requests for the
32-bit and 64-bit .dts changes, so patches should also follow that
schema

with that fixed, you can add my ACK on both (32-bit and 64-bit) .dts patches:
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 3 +--
>  4 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index b98d44fde6b6..f93d6cf6e094 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -289,9 +289,8 @@
>  &saradc {
>         compatible = "amlogic,meson8-saradc", "amlogic,meson-saradc";
>         clocks = <&clkc CLKID_XTAL>,
> -               <&clkc CLKID_SAR_ADC>,
> -               <&clkc CLKID_SANA>;
> -       clock-names = "clkin", "core", "sana";
> +               <&clkc CLKID_SAR_ADC>;
> +       clock-names = "clkin", "core";
>  };
>
>  &spifc {
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index bc278da7df0d..4aa444284f0c 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -185,9 +185,8 @@
>  &saradc {
>         compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
>         clocks = <&clkc CLKID_XTAL>,
> -               <&clkc CLKID_SAR_ADC>,
> -               <&clkc CLKID_SANA>;
> -       clock-names = "clkin", "core", "sana";
> +               <&clkc CLKID_SAR_ADC>;
> +       clock-names = "clkin", "core";
>  };
>
>  &uart_AO {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index af834cdbba79..b77f2593cdc3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -686,10 +686,9 @@
>         compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
>         clocks = <&xtal>,
>                  <&clkc CLKID_SAR_ADC>,
> -                <&clkc CLKID_SANA>,
>                  <&clkc CLKID_SAR_ADC_CLK>,
>                  <&clkc CLKID_SAR_ADC_SEL>;
> -       clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> +       clock-names = "clkin", "core", "adc_clk", "adc_sel";
>  };
>
>  &sd_emmc_a {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index d8dd3298b15c..07805a3b4db0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -628,10 +628,9 @@
>         compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
>         clocks = <&xtal>,
>                  <&clkc CLKID_SAR_ADC>,
> -                <&clkc CLKID_SANA>,
>                  <&clkc CLKID_SAR_ADC_CLK>,
>                  <&clkc CLKID_SAR_ADC_SEL>;
> -       clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> +       clock-names = "clkin", "core", "adc_clk", "adc_sel";
>  };
>
>  &sd_emmc_a {
> --
> 2.14.1
>
