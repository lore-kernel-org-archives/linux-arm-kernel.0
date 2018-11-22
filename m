From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 22 Nov 2018 08:54:18 +0100
Subject: [PATCHv2] ARM: dts: exynos: update the usbdrd_phy suspend clk
In-Reply-To: <20181120185536.1159-1-linux.amoon@gmail.com>
References: <20181120185536.1159-1-linux.amoon@gmail.com>
Message-ID: <CAJKOXPcphirR=+25evzVxHGv1g_4xNfPv3gazXWOes1G6iBt5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2018 at 19:55, Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per FSYS usbdrd_phy clk setting CLK_SCLK_USBD300/1 binds
> to SUSPEND_CLK so correct update the suspend clk.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> [0] https://lkml.org/lkml/2017/10/6/12
> changes from previous patch
> fix the order of clk and update the commit message
>
> FSYS block show in user manual
>
> CLKMUX_USBDRD300/1----CLKDIV_USBDRD300/1----SCLK_USBDRD300/1-----SUSPEND_CLK
>                    |
>                    |--CLKDIV_USBPHY300/1----SCLK_USBPHY300/1-----USBDRD30_PHY_0/1

Your new clock - SCLK_USBD301 - is not mentioned here. I don't get the
reason behind this change.

Best regards,
Krzysztof

> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 4 ++--
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 57fc9c949e54..a92c765a7a84 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -395,7 +395,7 @@
>  };
>
>  &usbdrd_phy0 {
> -       clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
> +       clocks = <&clock CLK_SCLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
>         clock-names = "phy", "ref";
>         samsung,pmu-syscon = <&pmu_system_controller>;
>  };
> @@ -410,7 +410,7 @@
>  };
>
>  &usbdrd_phy1 {
> -       clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
> +       clocks = <&clock CLK_SCLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
>         clock-names = "phy", "ref";
>         samsung,pmu-syscon = <&pmu_system_controller>;
>  };
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff15880761..b84b44556efc 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1509,7 +1509,7 @@
>  };
>
>  &usbdrd_phy0 {
> -       clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
> +       clocks = <&clock CLK_SCLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
>         clock-names = "phy", "ref";
>         samsung,pmu-syscon = <&pmu_system_controller>;
>  };
> @@ -1524,7 +1524,7 @@
>  };
>
>  &usbdrd_phy1 {
> -       clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
> +       clocks = <&clock CLK_SCLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
>         clock-names = "phy", "ref";
>         samsung,pmu-syscon = <&pmu_system_controller>;
>  };
> --
> 2.17.1
>
