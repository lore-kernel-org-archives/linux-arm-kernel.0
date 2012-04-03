From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 03 Apr 2012 13:55:28 +0200
Subject: [PATCH v2 00/13] at91: 3.4-rc1 fixes
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <4F7AE530.1040201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2012 09:32 AM, Nicolas Ferre :
> Here is a bunch of fixes for AT91 that will go on top of 3.4-rc1.
> Some modifications are related to certain drivers (USB ohci-at91 for instance)
> but are touching the core AT91 devices/board files and Device Tree files.
> The modification of "vbus_pin_active_low" in particular cannot be separated
> from the modification of .dts[i] and devices/board files.
> 
> I will have to collect "Acked-by" from USB people on the ohci-at91
> modifications (Greg?). I will try to find them just after having posted
> this v2 today...

Hi Greg,

I would like to send this "fixes" patch series via arm-soc. Is it
possible for you to have a look at patches that will modify ohci-at91
(and the tiny ehci-atmel one) and give me your "Acked-by" so that I can
ask Arnd and Olof to queue this material for 3.4-rc?

Here is the thread in linux-usb mainling-list:
http://www.spinics.net/lists/linux-usb/msg60798.html

Thanks for your help, best regards,

> Ludovic Desroches (1):
>   ARM: at91: dt: remove unit-address part for memory nodes
> 
> Nicolas Ferre (12):
>   ARM: at91/at91sam9x5: add clkdev entries for DMA controllers
>   USB: ohci-at91: fix vbus_pin_active_low handling
>   ARM: at91/USB host: specify and handle properly vbus_pin_active_low
>   ARM: at91/dts: USB host vbus is active low
>   USB: ohci-at91: rework and fix initialization
>   USB: ohci-at91: change maximum number of ports
>   USB: ohci-at91: coding style modifications with one-line ifs
>   USB: ohci-at91: trivial return code name change
>   ARM: at91/at91sam9x5.dtsi: fix NAND ale/cle in DT file
>   ARM: at91/NAND DT bindings: add comments
>   USB: ehci-atmel: add needed of.h header file
>   ARM: at91: fix check of valid GPIO for SPI and USB
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt         |   10 +-
>  arch/arm/boot/dts/at91sam9g20.dtsi                 |    2 +-
>  arch/arm/boot/dts/at91sam9g25ek.dts                |    4 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    2 +-
>  arch/arm/boot/dts/at91sam9m10g45ek.dts             |    6 +-
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    6 +-
>  arch/arm/boot/dts/at91sam9x5cm.dtsi                |    2 +-
>  arch/arm/boot/dts/usb_a9g20.dts                    |    2 +-
>  arch/arm/mach-at91/at91sam9260_devices.c           |    3 +
>  arch/arm/mach-at91/at91sam9261_devices.c           |    3 +
>  arch/arm/mach-at91/at91sam9263_devices.c           |    6 +-
>  arch/arm/mach-at91/at91sam9g45_devices.c           |   11 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c            |    3 +
>  arch/arm/mach-at91/at91sam9x5.c                    |    2 +
>  arch/arm/mach-at91/board-sam9263ek.c               |    1 +
>  arch/arm/mach-at91/board-sam9m10g45ek.c            |    1 +
>  arch/arm/mach-at91/include/mach/board.h            |   13 +-
>  drivers/usb/host/ehci-atmel.c                      |    1 +
>  drivers/usb/host/ohci-at91.c                       |  159 +++++++++++---------
>  19 files changed, 135 insertions(+), 102 deletions(-)
> 
> Thanks, best regards,


-- 
Nicolas Ferre
