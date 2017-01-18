From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 11:21:47 +0100
Subject: [PATCH 1/2] pinctrl: meson: fix uart_ao_b for GXBB and GXL/GXM
In-Reply-To: <20170115222029.8271-2-martin.blumenstingl@googlemail.com>
References: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
 <20170115222029.8271-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdaDB5LoNSdUFUdypHbUseo0KqKiK1hteeD5RK1KkF60XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 15, 2017 at 11:20 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> The GXBB and GXL/GXM pinctrl drivers had a configuration which conflicts
> with uart_ao_a. According to the GXBB ("S905") datasheet the AO UART
> functions are:
> - GPIOAO_0: Func1 = UART_TX_AO_A (bit 12), Func2 = UART_TX_AO_B (bit 26)
> - GPIOAO_1: Func1 = UART_RX_AO_A (bit 11), Func2 = UART_RX_AO_B (bit 25)
> - GPIOAO_4: Func2 = UART_TX_AO_B (bit 24)
> - GPIOAO_5: Func2 = UART_RX_AO_B (bit 25)
>
> The existing definition for uart_AO_A already uses GPIOAO_0 and GPIOAO_1.
> The old definition of uart_AO_B however was broken, as it used GPIOAO_0
> for TX (which would be fine) and two pins (GPIOAO_1 and GPIOAO_5) for RX
> (which does not make any sense).
>
> This fixes the uart_AO_B configuration by moving it to GPIOAO_4 and
> GPIOAO_5 (it would be possible to use GPIOAO_0 and GPIOAO_1 in theory,
> but all existing hardware uses uart_AO_A there).
> The fix for GXBB and GXL/GXM is identical since it seems that these
> specific pins are identical on both SoC variants.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied for fixes.

Yours,
Linus Walleij
