From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 22 Jul 2014 16:25:52 -0700
Subject: [GIT PULL] mach-bcm: brcmstb platform support for 3.17
Message-ID: <20140722232552.GJ28323@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

The following changes since commit 9a3c4145af32125c5ee39c0272662b47307a8323:

  Linux 3.16-rc6 (2014-07-20 21:04:16 -0700)

are available in the git repository at:

  git://github.com/brcm/linux.git tags/for-3.17/brcmstb

for you to fetch changes up to 4ba80cbf72940f44fc82067b66221996a20b23f1:

  MAINTAINERS: add entry for Broadcom ARM STB architecture (2014-07-22 16:17:29 -0700)

Let me know if you'd prefer just Acked/Signed-off-by/Reviewed-by patches
sent to your mailbox instead of git pull reqs.

I expect these patches to go in through Russel King and through
drivers/power/, so I left them out:

  ARM: Enable erratum 798181 for Broadcom Brahma-B15
  ARM: do CPU-specific init for Broadcom Brahma15 cores
  power: reset: Add reboot driver for brcmstb

----------------------------------------------------------------
brcmstb platform support, for BCM7xxx STB SoCs
----------------------------------------------------------------
Brian Norris (2):
      ARM: brcmstb: select GISB arbiter and interrupt drivers
      MAINTAINERS: add entry for Broadcom ARM STB architecture

Marc Carino (6):
      ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs
      ARM: brcmstb: add debug UART for earlyprintk support
      ARM: brcmstb: add CPU binding for Broadcom Brahma15
      ARM: brcmstb: add misc. DT bindings for brcmstb
      ARM: brcmstb: gic: add compatible string for Broadcom Brahma15
      ARM: brcmstb: dts: add a reference DTS for Broadcom 7445

 .../devicetree/bindings/arm/brcm-brcmstb.txt       |  95 ++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig.debug                             |  16 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts         |  14 +
 arch/arm/boot/dts/bcm7445.dtsi                     | 111 +++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/mach-bcm/Kconfig                          |  16 +
 arch/arm/mach-bcm/Makefile                         |   5 +
 arch/arm/mach-bcm/brcmstb.c                        |  28 ++
 arch/arm/mach-bcm/brcmstb.h                        |  19 ++
 arch/arm/mach-bcm/headsmp-brcmstb.S                |  33 ++
 arch/arm/mach-bcm/platsmp-brcmstb.c                | 363 +++++++++++++++++++++
 15 files changed, 713 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
 create mode 100644 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
 create mode 100644 arch/arm/boot/dts/bcm7445.dtsi
 create mode 100644 arch/arm/mach-bcm/brcmstb.c
 create mode 100644 arch/arm/mach-bcm/brcmstb.h
 create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 create mode 100644 arch/arm/mach-bcm/platsmp-brcmstb.c
