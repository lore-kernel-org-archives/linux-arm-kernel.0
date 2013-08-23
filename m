From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 19:38:38 +0200
Subject: [PATCH v4 3/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <1376938761-13657-4-git-send-email-markus.mayer@linaro.org>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-4-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdZgZeoYA1_jkkMMojpBSUs5K9BNeC60sQGbJw6zDf=ptA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 8:59 PM, Markus Mayer <markus.mayer@linaro.org> wrote:

> GPIO device tree bindings for the Broadcom bcm281xx family of chips
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index c0cdf66..a3945e3 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -63,6 +63,22 @@
>                 clock-frequency = <32768>;
>         };
>
> +       gpio: gpio at 35003000 {
> +               compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
> +               reg = <0x35003000 0x800>;
> +               interrupts =
> +                      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +               #gpio-cells = <2>;
> +               #interrupt-cells = <2>;
> +               gpio-controller;
> +               interrupt-controller;
> +       };

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
