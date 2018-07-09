From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jul 2018 15:40:26 +0200
Subject: [PATCH v2] pinctrl: at91-pio4: add support for drive strength
In-Reply-To: <20180629081533.31885-1-ludovic.desroches@microchip.com>
References: <20180629081533.31885-1-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdYyeFTsPe+pR26DCO5uOkLZu-+Nz8vDdEg47NWn4f-4Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 10:19 AM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Add support for the drive strength configuration. Usually, this value is
> expressed in mA. Since the numeric value depends on VDDIOP voltage, a
> value we can't retrieve at runtime, the controller uses low, medium and
> high to define the drive strength.
>
> The PIO controller accepts two values for the low drive configuration: 0
> and 1. Most of the time, we don't care about the drive strength. So we
> keep the default value which is 0. The drive strength is advertised
> through the sysfs only when it has been explicitly set in the device
> tree i.e. if its value is different from 0.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>
> Changes:
> - v2: use atmel,drive-strength property instead of drive-strengh one
> since it is not expressend in mA and there is no way to retrieve this
> value at runtime.

Patch applied with Rob's ACK!

Yours,
Linus Walleij
