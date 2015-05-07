From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 07 May 2015 09:34:22 +0800
Subject: [PATCH v4 0/7] Basic support to ZTE ZX296702
In-Reply-To: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
Message-ID: <554AC11E.2030800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?04?28? 17:18, Jun Nie wrote:
> Rebase patches of v2 to 4.0-rc1. Ready for merge.

Hi Arnd,

Do you see any issue in this patch set? Or could you help drive merge? 
Thank you very much!

Jun

> Change in v4 vs v3: Fix minor defconfig issue.
>
> Jun Nie (7):
>    ARM: zx: add basic support for ZTE ZX296702
>    MAINTAINERS: add entry for ARM ZTE architecture
>    ARM: zx: add low level debug support for zx296702
>    ARM: dts: zx: add an initial zx296702 dts and doc
>    clk: zx: add clock support to zx296702
>    ARM: zx: enable SMP and hotplug for zx296702
>    ARM: zx: Add basic defconfig support for ZX296702
>
>   Documentation/devicetree/bindings/arm/zte.txt      |  15 +
>   .../devicetree/bindings/clock/zx296702-clk.txt     |  35 ++
>   Documentation/devicetree/bindings/serial/pl011.txt |   2 +-
>   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>   MAINTAINERS                                        |   9 +
>   arch/arm/Kconfig                                   |   2 +
>   arch/arm/Kconfig.debug                             |  14 +
>   arch/arm/Makefile                                  |   1 +
>   arch/arm/boot/dts/Makefile                         |   1 +
>   arch/arm/boot/dts/zx296702-ad1.dts                 |  48 ++
>   arch/arm/boot/dts/zx296702.dtsi                    | 139 +++++
>   arch/arm/configs/zx_defconfig                      | 130 ++++
>   arch/arm/include/debug/pl01x.S                     |   7 +
>   arch/arm/mach-zx/Kconfig                           |  18 +
>   arch/arm/mach-zx/Makefile                          |   2 +
>   arch/arm/mach-zx/core.h                            |  19 +
>   arch/arm/mach-zx/headsmp.S                         |  32 +
>   arch/arm/mach-zx/platsmp.c                         | 189 ++++++
>   arch/arm/mach-zx/zx296702.c                        |  31 +
>   drivers/clk/Makefile                               |   1 +
>   drivers/clk/zte/Makefile                           |   2 +
>   drivers/clk/zte/clk-pll.c                          | 180 ++++++
>   drivers/clk/zte/clk-zx296702.c                     | 658 +++++++++++++++++++++
>   drivers/clk/zte/clk.h                              |  30 +
>   include/dt-bindings/clock/zx296702-clock.h         | 162 +++++
>   25 files changed, 1727 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
>   create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
>   create mode 100644 arch/arm/boot/dts/zx296702.dtsi
>   create mode 100644 arch/arm/configs/zx_defconfig
>   create mode 100644 arch/arm/mach-zx/Kconfig
>   create mode 100644 arch/arm/mach-zx/Makefile
>   create mode 100644 arch/arm/mach-zx/core.h
>   create mode 100644 arch/arm/mach-zx/headsmp.S
>   create mode 100644 arch/arm/mach-zx/platsmp.c
>   create mode 100644 arch/arm/mach-zx/zx296702.c
>   create mode 100644 drivers/clk/zte/Makefile
>   create mode 100644 drivers/clk/zte/clk-pll.c
>   create mode 100644 drivers/clk/zte/clk-zx296702.c
>   create mode 100644 drivers/clk/zte/clk.h
>   create mode 100644 include/dt-bindings/clock/zx296702-clock.h
>
