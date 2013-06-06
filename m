From: monstr@monstr.eu (Michal Simek)
Date: Thu, 06 Jun 2013 11:00:58 +0200
Subject: [GIT PULL v2] arm-soc: Xilinx zynq clock changes for v3.11
In-Reply-To: <20130601234708.21525.1684@quantum>
References: <51A31045.1060406@monstr.eu>
 <20130601051913.GC5189@quad.lixom.net> <20130601234708.21525.1684@quantum>
Message-ID: <51B04FCA.1090905@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following changes to your arm-soc tree.
This is the second pull request based on our discussion with Mike
I have added Mike's ACK to all patches.

Thanks,
Michal

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-clk-for-3.11

for you to fetch changes up to 97c4e87d45498fb4d18c995721bba72345a7d257:

  clk: zynq: Remove deprecated clock code (2013-05-27 09:21:49 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq clock changes for v3.11

Change Xilinx Zynq DT clock description which
reflects logical abstraction of Zynq's clock tree.

- Refactor PLL driver
- Use new clock controller driver
- Change timer and uart drivers

----------------------------------------------------------------
Soren Brinkmann (4):
      clk: zynq: Factor out PLL driver
      clk: zynq: Add clock controller driver
      arm: zynq: Migrate platform to clock controller
      clk: zynq: Remove deprecated clock code

 Documentation/devicetree/bindings/clock/zynq-7000.txt | 123 +++++++---
 arch/arm/boot/dts/zynq-7000.dtsi                      |  71 ++----
 arch/arm/boot/dts/zynq-zc702.dts                      |   4 -
 arch/arm/mach-zynq/slcr.c                             |   2 +-
 drivers/clk/Makefile                                  |   2 +-
 drivers/clk/clk-zynq.c                                | 378 -------------------------------
 drivers/clk/zynq/Makefile                             |   3 +
 drivers/clk/zynq/clkc.c                               | 533 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zynq/pll.c                                | 235 +++++++++++++++++++
 drivers/clocksource/cadence_ttc_timer.c               |  23 +-
 drivers/tty/serial/xilinx_uartps.c                    |  85 +++++--
 include/linux/clk/zynq.h                              |   8 +-
 12 files changed, 972 insertions(+), 495 deletions(-)
 delete mode 100644 drivers/clk/clk-zynq.c
 create mode 100644 drivers/clk/zynq/Makefile
 create mode 100644 drivers/clk/zynq/clkc.c
 create mode 100644 drivers/clk/zynq/pll.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130606/c31e185c/attachment.sig>
