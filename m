From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Jun 2015 08:38:23 +0100
Subject: [PATCH v2 00/12] mfd: Add support for Clocksource to LPC set
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150601073823.GB3329@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device Tree Maintainers,

All of the functional patches in this series have been Acked by the
relevant maintainers, but the (pretty simple) DT changes are in need
of a suitable Ack.

Would someone mine glancing over them please?

> ST's Low Power Controller (LPC) controls three devices; watchdog, RTC
> and a Clocksource Timer.  Only one of the devices can be used at any
> one time, which is enforced by the Device Driver model.
>  
> This patchset provides support for the Clocksource driver.  Watchdog
> and RTC are already in -next.
> 
> Lee Jones (12):
>   mfd: dt-bindings: Provide human readable define for Clocksource mode
>   clocksource: sti: Provide support for the ST LPC Clocksource IP
>   clocksource: sti: Provide 'use timer as sched clock' capability
>   clocksource: bindings: Provide bindings for ST's LPC Clocksource
>     device
>   watchdog: st_wdt: Update IP layout information to include Clocksource
>   watchdog: bindings: Supply knowledge of a third supported device -
>     clocksource
>   rtc: st: Update IP layout information to include Clocksource
>   rtc: bindings: Supply knowledge of a third supported device -
>     clocksource
>   MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
>   ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
>   ARM: STi: Enable LPC Clocksource
>   ARM: STi: Update platform level menuconfig 'help'
> 
>  .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  15 ++-
>  .../devicetree/bindings/timer/st,stih407-lpc       |  28 +++++
>  .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  12 +-
>  MAINTAINERS                                        |   1 +
>  arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
>  arch/arm/mach-sti/Kconfig                          |  10 +-
>  drivers/clocksource/Kconfig                        |   9 ++
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/clksrc_st_lpc.c                | 129 +++++++++++++++++++++
>  drivers/rtc/rtc-st-lpc.c                           |   2 +-
>  drivers/watchdog/st_lpc_wdt.c                      |   2 +-
>  include/dt-bindings/mfd/st-lpc.h                   |   1 +
>  12 files changed, 194 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stih407-lpc
>  create mode 100644 drivers/clocksource/clksrc_st_lpc.c
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
