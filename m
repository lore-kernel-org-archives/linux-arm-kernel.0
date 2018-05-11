From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 11 May 2018 07:22:19 -0500
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
In-Reply-To: <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
Message-ID: <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 4:16 AM,  <djw@t-chip.com.cn> wrote:
> From: Levin Du <djw@t-chip.com.cn>
>
> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
> access to the pins defined in the syscon GRF_SOC_CON10.
>
> Boards using these special pins to control regulators or LEDs, can now
> utilize existing drivers like gpio-regulator and leds-gpio.
>
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>
> ---
>
> Changes in v1:
> - Split from V0 and add to rk3328.dtsi for general use.
>
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index b8e9da1..73a822d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -309,6 +309,12 @@
>                         mode-loader = <BOOT_BL_DOWNLOAD>;
>                 };
>
> +               gpio_syscon10: gpio-syscon10 {

GPIO controller nodes should be named just 'gpio'.

> +                       compatible = "rockchip,gpio-syscon";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio,syscon-dev = <0 0x0428 0>;

This property is not documented and takes a phandle.

> +               };
>         };
>
>         uart0: serial at ff110000 {
> --
> 2.7.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
