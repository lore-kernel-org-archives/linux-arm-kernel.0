From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Mar 2016 12:18:46 +0100
Subject: [PATCH v5 0/2] power: reset: support for Atmel alternative
 Shutdown Controller
In-Reply-To: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <56F27B96.5010406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/03/2016 14:19, Nicolas Ferre a ?crit :
> This is a series to add driver for a new Atmel Shutdown Controller. This new IP
> is extensible and some features will be added later (see the TODO section).
> Its extensible nature led to write a new binding so that wake-up sources can be
> described easily.

Sebastian,

I have the feeling that this series is ready. What do you think?

So, do you want me to collect everybody's tags and send another version
or you can do it yourself?

BTW, I will certainly send the device tree updates for the sama5d2 SoC,
but it will go through the AT91 then arm-soc git trees. No need for
further synchronization here.

Bye,


> Changes in v5:
> - Instead of the "alternate shdwc" we choose a more specific
>   "sama5d2-compatible shdwc" wording. Change file name, in Kconfig, and the
>   MAINTAINERS file:
>   at91-shdwc.c -> at91-sama5d2_shdwc.c
>   "ATMEL AT91 Alternative Shutdown Controller" -> "ATMEL AT91 SAMA5D2-Compatible
>   Shutdown Controller"
> - fix one indentation mismatch
> 
> Changes in v4:
> - change property to debounce-delay-us so that we can use a generic property
>   and we can have the unit explicitly included it the name according to
>   Documentation/devicetree/bindings/property-units.txt.
> - move to atmel,wakeup-active-high boolean property instead of a "high", "low"
>   string comparison.
> - fix warning found by 0-day robot: large integer implicitly truncated to
>   unsigned type [-Woverflow]
> - move to the property debounce-delay-us
> - move to atmel,wakeup-active-high boolean
> - add entry in MAINTAINERS file
> 
> Changes in v3:
> - get and use slow clock and specify its handler in binding
> - add the slow clock handle as the IP uses it
> - remove useless protection at the beginning of pm_power_off handler
> - allow to compile it as a module
> - add COMPILE_TEST directive in Kconfig
> - update description in file header
> 
> Changes in v2:
> - add MODULE_DEVICE_TABLE as advised by Sebastian Reichel
> - review indentation and braces to correct errors pointed out by checkpatch
> 
> Nicolas Ferre (2):
>   ARM: dts: at91: shdwc binding: add new shutdown controller
>     documentation
>   power: reset: at91-shdwc: add new shutdown controller driver
> 
>  .../devicetree/bindings/arm/atmel-at91.txt         |  59 +++++
>  MAINTAINERS                                        |   5 +
>  drivers/power/reset/Kconfig                        |   8 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/at91-sama5d2_shdwc.c           | 282 +++++++++++++++++++++
>  5 files changed, 355 insertions(+)
>  create mode 100644 drivers/power/reset/at91-sama5d2_shdwc.c
> 


-- 
Nicolas Ferre
