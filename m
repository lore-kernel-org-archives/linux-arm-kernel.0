From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Sep 2014 17:29:49 -0700
Subject: [GIT PULL] Add initial support for Broadcom Cygnus SoC
Message-ID: <1411691389-22140-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/bcm-cygnus-soc-v2

for you to fetch changes up to 34daad2439ad12301618935e2fe2e8ba7080a3e9:

  MAINTAINERS: Entry for Cygnus/iproc arm architecture and clock drivers (2014-09-25 17:21:44 -0700)

----------------------------------------------------------------
Jonathan Richardson (6):
      ARM: cygnus: Initial support for Broadcom Cygnus SoC
      clk: Clock driver support for Broadcom Cygnus SoC
      dt-bindings: Document Broadcom Cygnus SoC and clock driver
      ARM: dts: Enable Broadcom Cygnus SoC
      ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC
      MAINTAINERS: Entry for Cygnus/iproc arm architecture and clock drivers

 Documentation/devicetree/bindings/arm/cygnus.txt   |   12 +
 .../devicetree/bindings/clock/clk-cygnus.txt       |  121 ++
 .../devicetree/bindings/clock/clk-iproc.txt        |   48 +
 MAINTAINERS                                        |   21 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  349 ++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |   22 +
 arch/arm/configs/bcm_cygnus_defconfig              |  223 ++++
 arch/arm/mach-bcm/Kconfig                          |   31 +
 arch/arm/mach-bcm/Makefile                         |    3 +
 arch/arm/mach-bcm/bcm_cygnus.c                     |  166 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/bcm/Makefile                           |    2 +
 drivers/clk/bcm/clk-cygnus.c                       | 1186 ++++++++++++++++++++
 drivers/clk/bcm/clk-iproc.c                        |  451 ++++++++
 15 files changed, 2637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-iproc.txt
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts
 create mode 100644 arch/arm/configs/bcm_cygnus_defconfig
 create mode 100644 arch/arm/mach-bcm/bcm_cygnus.c
 create mode 100644 drivers/clk/bcm/clk-cygnus.c
 create mode 100644 drivers/clk/bcm/clk-iproc.c
