From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 14:30:53 +0100
Subject: [PATCH 00/12] Atmel matrix, SMC and UDC rework
In-Reply-To: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54B7C10D.1090008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/01/2015 17:21, Alexandre Belloni a ?crit :
> Hi Felipe,
> 
> The following series replace the previous series sent by Boris named:
>  - [PATCH v5 00/11] memory: add Atmel EBI (External Bus Interface) driver
>  - [PATCH 00/11] usb: gadget: at91_udc: Rework for multi-platform support
> 
> The patches I left out are less urgent and will be resent later, probably for
> 3.21.
> 
> Because of the dependancy between the syscon addition and the at91_udc series,
> this can go through the AT91 tree if you giv your ack on the udc patches.
> 
> The first 4 patches introduce 2 syscon devices needed to configure the
> matrix and SMC.
> The following patches rework the at91_udc driver to prepare at91 for
> multi-platform support.
> 
> It also include several fixes:
>  - fix clock names to be consistent with other USB drivers
>  - document clocks and clock-names properties in atmel-usb DT bindings doc
> 
> and some cleanup changes:
>  - remove useless usb_clk
>  - allocate at91_udc instance instead of using the statically defined one
>  - simplify the probe and remove functions by using devm_ helpers
>  - remove !DT specific code
> 
> Changes from the previous series:
>  - rebased on 3.19-rc1
>
> Boris Brezillon (12):
>   mfd: syscon: Add atmel-matrix registers definition
>   mfd: syscon: Add Atmel Matrix bus DT binding documentation
>   mfd: syscon: Add atmel-smc registers definition
>   mfd: syscon: Add Atmel SMC binding doc

I already acknowledged these 4 patches as part of another series.

>   usb: gadget: at91_udc: Fix clock names
>   usb: gadget: at91_udc: Drop uclk clock
>   usb: gadget: at91_udc: Document DT clocks and clock-names property
>   usb: gadget: at91_udc: Remove non-DT handling code
>   usb: gadget: at91_udc: Simplify probe and remove functions
>   usb: gadget: at91_udc: Rework for multi-platform kernel support
>   usb: gadget: at91_udc: Update DT binding documentation
>   usb: gadget: at91_udc: Allocate udc instance

I'm fine with all this:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Great, I plan to add them all to the at91-3.20-drivers branch now.

Thanks, best regards.


>  .../devicetree/bindings/mfd/atmel-matrix.txt       |  24 +
>  .../devicetree/bindings/mfd/atmel-smc.txt          |  19 +
>  .../devicetree/bindings/usb/atmel-usb.txt          |  10 +-
>  drivers/usb/gadget/udc/Kconfig                     |   1 +
>  drivers/usb/gadget/udc/at91_udc.c                  | 525 +++++++++++----------
>  drivers/usb/gadget/udc/at91_udc.h                  |   9 +-
>  include/linux/mfd/syscon/atmel-matrix.h            | 117 +++++
>  include/linux/mfd/syscon/atmel-smc.h               | 173 +++++++
>  8 files changed, 623 insertions(+), 255 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-matrix.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-smc.txt
>  create mode 100644 include/linux/mfd/syscon/atmel-matrix.h
>  create mode 100644 include/linux/mfd/syscon/atmel-smc.h
> 


-- 
Nicolas Ferre
