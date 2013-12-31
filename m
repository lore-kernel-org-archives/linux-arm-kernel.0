From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 31 Dec 2013 18:48:29 +0100
Subject: [PATCH 0/6] Device Tree support for the at91sam9261ek
In-Reply-To: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52C3036D.50503@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Jacques

On 31/12/2013 17:32, jjhiblot at traphandler.com wrote:
> From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>
> Hi Nicolas,
>
> This patch set aims at bringing a basic device tree support for the sam9261.
> It's mostly based on the sam9263 stuff.
> The only new thing here is the smc bus driver. It's a very simple bus driver
> used to configure the EBI from the DT. I haven't documented its DT bindings yet
>
> supported features:
> * dbgu
> * nand
> * lcd
> * ethernet
> * leds
>

Cool, one step forward to the removal of at91 board files ;).

I'll try to review this series before the end of the week.

Best Regards,

Boris


> Jean-Jacques
>
> jean-jacques hiblot (6):
>    Basic Device Tree support for the at91sam9261
>    at91: dt: sam9261: Added support for the lcd display
>    At91: dt: Added smc bus driver
>    at91: dt: sam9261: Pinmux DT entries for the SMC/EBI interface
>    at91: dt: sam9261: Add an entry in the DT for the SMC/EBI bus driver.
>    at91: dt: sam9261: Added DM9000 in the device tree
>
> jean-jacques hiblot (6):
>    Basic Device Tree support for the at91sam9261
>    at91: dt: sam9261: Added support for the lcd display
>    At91: dt: Added smc bus driver
>    at91: dt: sam9261: Pinmux DT entries for the SMC/EBI interface
>    at91: dt: sam9261: Add an entry in the DT for the SMC/EBI bus driver.
>    at91: dt: sam9261: Added DM9000 in the device tree
>
>   arch/arm/boot/dts/at91sam9261.dtsi       | 575 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91sam9261ek.dts      | 159 +++++++++
>   arch/arm/mach-at91/at91sam9261.c         |  16 +
>   arch/arm/mach-at91/at91sam9261_devices.c |  18 +
>   drivers/bus/Kconfig                      |   9 +
>   drivers/bus/Makefile                     |   1 +
>   drivers/bus/atmel-smc.c                  | 182 ++++++++++
>   7 files changed, 960 insertions(+)
>   create mode 100644 arch/arm/boot/dts/at91sam9261.dtsi
>   create mode 100644 arch/arm/boot/dts/at91sam9261ek.dts
>   create mode 100644 drivers/bus/atmel-smc.c
>
