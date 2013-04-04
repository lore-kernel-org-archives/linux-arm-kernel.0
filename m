From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 4 Apr 2013 09:39:02 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq timer changes for v3.10
Message-ID: <1e33aafc-ee95-42ab-b5d7-048c1d7d0664@CO9EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull these zynq timer changes to your arm-soc tree.

This tree is based on clksrc/cleanup branch because these changes related
on Rob changes in clksrc-of.c.

Please let me know if you have any problem with it.

Thanks,
Michal


The following changes since commit 3d5a96582303e28c48699f3faaf920ef7d43e6f2:

   clocksource: make CLOCKSOURCE_OF_DECLARE type safe (2013-03-28 12:01:06 +0100)

are available in the git repository at:

   git://git.xilinx.com/linux-xlnx.git zynq/clksrc/cleanup

for you to fetch changes up to 4f0f234fce1d263cc9881456352e8fd56ead0514:

   arm: zynq: Move timer to generic location (2013-04-04 09:22:09 +0200)

----------------------------------------------------------------
Michal Simek (4):
       arm: zynq: Use standard timer binding
       arm: zynq: Move timer to clocksource interface
       arm: zynq: Do not use xilinx specific function names
       arm: zynq: Move timer to generic location

  .../bindings/timer/cadence,ttc-timer.txt           |   17 +
  arch/arm/boot/dts/zynq-7000.dtsi                   |   45 +-
  arch/arm/boot/dts/zynq-zc702.dts                   |   10 -
  arch/arm/mach-zynq/Kconfig                         |    1 +
  arch/arm/mach-zynq/Makefile                        |    2 +-
  arch/arm/mach-zynq/common.c                        |    3 +-
  arch/arm/mach-zynq/common.h                        |    2 -
  arch/arm/mach-zynq/timer.c                         |  324 ---------------
  drivers/clocksource/Kconfig                        |    3 +
  drivers/clocksource/Makefile                       |    1 +
  drivers/clocksource/cadence_ttc_timer.c            |  436 ++++++++++++++++++++
  11 files changed, 467 insertions(+), 377 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
  delete mode 100644 arch/arm/mach-zynq/timer.c
  create mode 100644 drivers/clocksource/cadence_ttc_timer.c
