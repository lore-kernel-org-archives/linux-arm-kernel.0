From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 23:46:27 +0200
Subject: [PATCH v2] pinctrl/at91: Fix mask creation in at91_gpio_dbg_show
In-Reply-To: <1397501588-19730-1-git-send-email-alexanders83@web.de>
References: <20140414081438.GI2967@piout.net>
 <1397501588-19730-1-git-send-email-alexanders83@web.de>
Message-ID: <CACRpkdY9QEx1BeOY+nTf0nVgr56OLw+qwfZ62Er_gu67s1J2Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 8:53 PM, Alexander Stein <alexanders83@web.de> wrote:

> pin_to_mask expects a bank pin number. So do not add the chip base.
>
> Without that patch cat /sys/kernel/debug/gpio looks like that:
> GPIOs 0-31, platform/fffff200.gpio, fffff200.gpio:
> [spi32766.0] GPIOfffff200.gpio5: [gpio] set
> [ads7846_pendown] GPIOfffff200.gpio15: [gpio] set
> [ohci_vbus] GPIOfffff200.gpio21: [gpio] set
> [ohci_vbus] GPIOfffff200.gpio24: [gpio] set
> [button1] GPIOfffff200.gpio28: [gpio] clear
> [button2] GPIOfffff200.gpio29: [gpio] clear
>
> GPIOs 32-63, platform/fffff400.gpio, fffff400.gpio:
> [sda] GPIOfffff400.gpio4: [periph A]
> [scl] GPIOfffff400.gpio5: [periph A]
> [spi32766.3] GPIOfffff400.gpio11: [periph A]
> [error] GPIOfffff400.gpio22: [periph A]
> [run] GPIOfffff400.gpio23: [periph A]
>
> GPIOs 64-95, platform/fffff600.gpio, fffff600.gpio:
> [reset_pin] GPIOfffff600.gpio29: [periph A]
>
> GPIOs 96-127, platform/fffff800.gpio, fffff800.gpio:
> [led1] GPIOfffff800.gpio5: [periph A]
> [led2] GPIOfffff800.gpio6: [periph A]
> [led3] GPIOfffff800.gpio7: [periph A]
> [led4] GPIOfffff800.gpio8: [periph A]
>
> GPIOs 128-159, platform/fffffa00.gpio, fffffa00.gpio:
> [button3] GPIOfffffa00.gpio10: [periph A]
> [button4] GPIOfffffa00.gpio12: [periph A]
>
> Note that every bank despite bank 0 only shows "periph A" which are
> obviously used as GPIOs.
>
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Changes in v2:
> * Added 2 Acked-by's
> * Add an example of wrong output

Patch applied.

Yours,
Linus Walleij
