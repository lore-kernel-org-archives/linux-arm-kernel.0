From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:38 +0800
Subject: [PATCH V2 0/9] ARM: sirf: drop CSR marco and add atlas7 platform
Message-ID: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patchset drops MARCO as it is not supported any more. its replacement
is atlas7.
some IPs from marco are moved to atlas7, for example timer. for this kind
of IPs, we rename to atlas7. some IPs need some change for atlas7, such as
platsmp, we break marco and move to atlas7 directly.

the patchset add debug ports, machine and devicetree for the new atlas7.

-v2:
 drop marco before adding atlas7;
 use DEBUG_UART_PHYS/VIRT and debug_ll_io_init;
 drop sirfsoc_map_io;
 correct timer tick;

 thanks very much for Arnd's feedbacks

Barry Song (5):
  ARM: sirf: drop MARCO low-level debug port
  ARM: dts: drop MARCO platform DT stuff
  ARM: sirf: drop MARCO support in reset controller module
  ARM: sirf: drop MARCO machine
  clocksource: marco: rename marco to atlas7

Guo Zeng (1):
  ARM: sirf: add two debug ports for CSRatlas7 SoC

Zhiwu Song (3):
  ARM: sirf: move platsmp to support atlas7 SoC
  ARM: sirf: add atlas7 machine support
  ARM: dts: add init dts file for CSR atlas7 SoC

 Documentation/devicetree/bindings/arm/sirf.txt     |   6 +-
 arch/arm/Kconfig.debug                             |  37 +-
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/atlas7-evb.dts                   | 110 +++
 arch/arm/boot/dts/atlas7.dtsi                      | 813 +++++++++++++++++++++
 arch/arm/boot/dts/marco-evb.dts                    |  54 --
 arch/arm/boot/dts/marco.dtsi                       | 757 -------------------
 arch/arm/include/debug/sirf.S                      |  30 +-
 arch/arm/mach-prima2/Kconfig                       |  22 +-
 arch/arm/mach-prima2/common.c                      |  22 +-
 arch/arm/mach-prima2/lluart.c                      |  35 -
 arch/arm/mach-prima2/platsmp.c                     |  52 +-
 arch/arm/mach-prima2/rstc.c                        |  41 +-
 arch/arm/mach-prima2/rtciobrg.c                    |   1 -
 drivers/clocksource/Makefile                       |   2 +-
 .../clocksource/{timer-marco.c => timer-atlas7.c}  |  15 +-
 16 files changed, 1021 insertions(+), 978 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi
 delete mode 100644 arch/arm/boot/dts/marco-evb.dts
 delete mode 100644 arch/arm/boot/dts/marco.dtsi
 delete mode 100644 arch/arm/mach-prima2/lluart.c
 rename drivers/clocksource/{timer-marco.c => timer-atlas7.c} (95%)

-- 
2.2.1
