From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 15:39:47 +0100
Subject: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdaW-OMgGfw8+ngia8AsmzRpW8z7922=dPpRGjgv79-gqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> The STMicrolectornics's STM32F419 MCU has the following main features:
>  - Cortex-M4 core running up to @180MHz
>  - 2MB internal flash, 256KBytes internal RAM
>  - FMC controller to connect SDRAM, NOR and NAND memories
>  - SD/MMC/SDIO support
>  - Ethernet controller
>  - USB OTFG FS & HS controllers
>  - I2C, SPI, CAN busses support
>  - Several 16 & 32 bits general purpose timers
>  - Serial Audio interface
>  - LCD controller
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +       soc {
> +               usart1: usart at 40011000 {
> +                       status = "okay";
> +               };
> +
> +               leds {
> +                       compatible = "gpio-leds";
> +                       red {
> +                               #gpio-cells = <2>;
> +                               label = "Front Panel LED";
> +                               gpios = <&gpiog 14 0>;
> +                               linux,default-trigger = "heartbeat";
> +                       };
> +                       green {
> +                               #gpio-cells = <2>;
> +                               gpios = <&gpiog 13 0>;
> +                               default-state = "off";
> +                       };
> +               };
> +       };

The LEDs are mounted on the board not the SoC, right?

So move them outside of the soc node, to the top level
of the DTS file.

Yours,
Linus Walleij
