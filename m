From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 17 Apr 2018 10:24:06 +0200
Subject: [PATCH 0/3] Fix an Atmel USBA UDC issue introducted in 4.17-rc1
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Message-ID: <cbdab54a-d01a-2668-c3bc-b5b334a555e0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/2018 at 11:34, Romain Izard wrote:
> The use of GPIO descriptors takes care of inversion flags declared in
> the device tree. The conversion of the Atmel USBA UDC driver introduced
> in 4.17-rc1 missed it, and as a result the inversion will not work.
> 
> In addition, cleanup the code to remove an include left behind after
> the suppression of the support of platform_data to declare USBA
> controllers.
> 
> These changes have not been tested on any hardware, as I do not have
> a board that needs to use inverted GPIOs.
> 
> Romain Izard (3):
>    usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
>    usb: gadget: udc: atmel: Remove obsolete include
>    usb: gadget: udc: atmel: Fix indenting

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thank you Romain.
Best regards,
   Nicolas

> 
>   drivers/usb/gadget/udc/atmel_usba_udc.c | 22 ++++++++++------------
>   drivers/usb/gadget/udc/atmel_usba_udc.h |  1 -
>   include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
>   3 files changed, 10 insertions(+), 37 deletions(-)
>   delete mode 100644 include/linux/usb/atmel_usba_udc.h
> 


-- 
Nicolas Ferre
