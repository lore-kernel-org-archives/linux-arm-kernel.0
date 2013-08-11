From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 Aug 2013 17:51:22 +0800
Subject: [PATCH 5/5] ARM: pxa: DTS: override gpio node in pxa3xx.dtsi
In-Reply-To: <1373555877-29887-6-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-6-git-send-email-zonque@gmail.com>
Message-ID: <CAD6h2NS8Uyn=YCwg0OoWLmnP8g2ckxDQ_Jhgcu1oejw7xZ9T6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2013 23:17, Daniel Mack <zonque@gmail.com> wrote:
> The gpio controller node inherited from pxa2xx.dtsi won't work for
> pxa3xx SoCs, so let's override it in pxa3xx.dtsi.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/pxa3xx.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
> index f9d92da..83bb0ef 100644
> --- a/arch/arm/boot/dts/pxa3xx.dtsi
> +++ b/arch/arm/boot/dts/pxa3xx.dtsi
> @@ -28,5 +28,16 @@
>                         marvell,intc-priority;
>                         marvell,intc-nr-irqs = <56>;
>                 };
> +
> +               gpio: gpio at 40e00000 {
> +                       compatible = "intel,pxa3xx-gpio";
> +                       reg = <0x40e00000 0x10000>;
> +                       interrupt-names = "gpio0", "gpio1", "gpio_mux";
> +                       interrupts = <8 9 10>;
> +                       gpio-controller;
> +                       #gpio-cells = <0x2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <0x2>;
> +               };
>         };
>  };
> --
> 1.8.1.4
>

Applied.

Regards
Haojian
