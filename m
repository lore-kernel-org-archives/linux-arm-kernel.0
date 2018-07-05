From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Jul 2018 12:04:57 -0600
Subject: [PATCH v2] pinctrl: at91-pio4: add support for drive strength
In-Reply-To: <20180629081533.31885-1-ludovic.desroches@microchip.com>
References: <20180629081533.31885-1-ludovic.desroches@microchip.com>
Message-ID: <20180705180457.GA5809@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 10:15:33AM +0200, Ludovic Desroches wrote:
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
> - v1: https://www.spinics.net/lists/linux-gpio/msg27789.html
> 
>  .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  3 ++
>  drivers/pinctrl/pinctrl-at91-pio4.c                | 42 ++++++++++++++++++++++
>  include/dt-bindings/pinctrl/at91.h                 |  4 +++
>  3 files changed, 49 insertions(+)

For the DT parts,

Acked-by: Rob Herring <robh@kernel.org>
