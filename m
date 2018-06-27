From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Jun 2018 07:38:14 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180627143814.fg7v6sjupytb3eyb@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 86676c4685f774d818f7a6c401c925bbf2a92903:

  arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards (2018-06-27 07:14:47 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A handful of fixes, nothing really concerning and most touching devicetree
files for various platforms.

I also regenerated the shared multiplatform defconfigs; they have drifted
quite a bit due to Kconfig changes and reordering, and several platform
maintainers tried doing the same which resulted in a lot of conflict pain
-- this way we get everybody onto the same base for next merge window.

----------------------------------------------------------------
Andy Gross (1):
      Merge tag 'qcom-fixes-for-4.18-rc1' into linus

Anson Huang (1):
      soc: imx: gpcv2: correct PGC offset

Arnd Bergmann (1):
      qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency

Dinh Nguyen (1):
      ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Florian Fainelli (6):
      MAINAINTERS: Corrected Broadcom Northstar2 entry
      MAINTAINERS: Update Broadcom iProc entry with Stingray
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types
      ARM: dts: HR2: Fix interrupt types for i2c and PCIe
      ARM: dts: BCM5301x: Fix i2c controller interrupt type

Geert Uytterhoeven (2):
      soc: renesas: rcar-sysc: Make PM domain initialization more robust
      ARM: Always build secure_cntvoff.S on ARM V7 to fix shmobile !SMP build

Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards

Marek Vasut (2):
      ARM: dts: socfpga: Fix NAND controller clock supply
      ARM: dts: socfpga: Fix NAND controller node compatible

Miquel Raynal (1):
      arm64: dts: marvell: fix CP110 ICU node size

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Olof Johansson (11):
      Merge tag 'mvebu-fixes-4.17-2' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'renesas-fixes-for-v4.18' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'imx-fixes-4.18' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'arm-soc/for-4.18/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.18/devicetree-arm64-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.18/maintainers-arm64-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'qcom-fixes-for-4.18-rc1' of git://git.kernel.org/.../agross/linux into fixes
      arm64: defconfig: renormalize based on recent additions
      ARM: multi_v7_defconfig: renormalize based on recent additions
      Merge tag 'socfpga_nand_fix_v4.17' of git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'qcom-fixes-for-4.18-rc2' of git://git.kernel.org/.../agross/linux into fixes

Ray Jui (5):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type
      arm64: dts: ns2: Fix I2C controller interrupt type
      arm64: dts: ns2: Fix PCIe controller interrupt type
      arm64: dts: Stingray: Fix I2C controller interrupt type

Rob Herring (1):
      arm64: dts: msm8916: fix Coresight ETF graph connections

Scott Branden (2):
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742t

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Srinivas Kandagatla (1):
      arm64: dts: apq8096-db820c: disable uart0 by default

Thor Thayer (2):
      arm64: dts: stratix10: Fix SPI nodes for Stratix10
      ARM: dts: Fix SPI node for Arria10

Viresh Kumar (1):
      arm: dts: armada: Fix "#cooling-cells" property's name

 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  24 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  24 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  32 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   2 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   4 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   5 +-
 arch/arm/common/Makefile                           |   2 +-
 arch/arm/configs/multi_v7_defconfig                | 378 +++++++++------------
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   6 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   8 +-
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |   4 +
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   4 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |   2 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |   2 +-
 arch/arm64/configs/defconfig                       | 102 +++---
 drivers/soc/imx/gpcv2.c                            |  13 +-
 drivers/soc/qcom/Kconfig                           |   3 +-
 drivers/soc/renesas/rcar-sysc.c                    |  35 +-
 26 files changed, 310 insertions(+), 364 deletions(-)
