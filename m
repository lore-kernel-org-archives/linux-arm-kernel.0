From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:13:57 +0100
Subject: [PATCH v2 00/41] Enable common clock with Device Tree on ux500
 platforms
Message-ID: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patchset has been applied, we can request clocks directly
from Device Tree without using any AUXDATA device-name hacks. We also
take care to remove all of those at the end of the set.

Most of the code is the same as the previous submission, but on Linus'
request we are starting with a new DT:ed clk_init() function instead
of converting the old one into dual purpose, the to DT only.

 arch/arm/boot/dts/dbx5x0.dtsi           | 124 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts          |   3 +-
 arch/arm/mach-ux500/cpu-db8500.c        |  41 ++-------
 arch/arm/mach-ux500/cpu.c               |  14 +++-
 arch/arm/mach-ux500/timer.c             |   4 +-
 drivers/clk/ux500/Makefile              |   1 +
 drivers/clk/ux500/u8500_of_clk.c        | 558 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ux500/u8540_clk.c           |   2 +-
 drivers/mfd/db8500-prcmu.c              |   1 -
 drivers/mfd/dbx500-prcmu-regs.h         |   1 -
 drivers/usb/musb/ux500.c                |   2 +-
 include/dt-bindings/mfd/dbx500-prcmu.h  |  83 ++++++++++++++++++
 include/linux/mfd/dbx500-prcmu.h        |  70 +---------------
 include/linux/platform_data/clk-ux500.h |   3 +
 14 files changed, 796 insertions(+), 111 deletions(-)
