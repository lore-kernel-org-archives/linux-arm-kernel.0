From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Jul 2014 14:33:03 +0530
Subject: [GIT PULL] ARM: SPEAr13xx PCIe updates for v3.17
Message-ID: <CAKohpo=T3taZx8e39tenCRBNxCUr=7H2xG7Ng=e+YQXuuY9u8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof/Arnd,

This is another attempt to merge SPEAr PCIe updates after olof
pointed out *enough* issues with initial PULL request:

https://lkml.org/lkml/2014/7/9/641

Last version was sent here: http://patchwork.ozlabs.org/patch/368479/
and all the nits pointed out by Kishon & Bjorn are fixed in this pull
request.

Apart from ARM specific changes, this updates drivers/{pci|phy}. Bjorn
advised to get complete series via arm-soc tree earlier:

http://www.spinics.net/lists/linux-pci/msg30271.html

Please let me know if I couldn't get it right this time.

--
viresh

---------x---------------x---------------

The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
spear/pcie-support-v10

for you to fetch changes up to f6e670a3b62d23722d04e801244a068755a45b7a:

  ARM: SPEAr13xx: Update defconfigs (2014-07-14 11:04:44 +0530)

----------------------------------------------------------------
Mohit Kumar (1):
      ARM: SPEAr13xx: Update defconfigs

Pratyush Anand (5):
      PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx
      phy: Add drivers for PCIe and SATA phy on SPEAr13xx
      ARM: SPEAr13xx: Fix static mapping table
      ARM: SPEAr13xx: Add bindings and dt node for misc block
      ARM: SPEAr13xx: Add pcie and miphy DT nodes

 .../devicetree/bindings/arm/spear-misc.txt         |   9 +
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |  14 +
 .../devicetree/bindings/phy/st-spear-miphy.txt     |  15 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/spear1310-evb.dts                |   4 +
 arch/arm/boot/dts/spear1310.dtsi                   |  93 ++++-
 arch/arm/boot/dts/spear1340-evb.dts                |   4 +
 arch/arm/boot/dts/spear1340.dtsi                   |  30 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   9 +-
 arch/arm/configs/spear13xx_defconfig               |  16 +
 arch/arm/mach-spear/Kconfig                        |   4 +
 arch/arm/mach-spear/include/mach/spear.h           |   4 +-
 arch/arm/mach-spear/spear1340.c                    | 125 +------
 arch/arm/mach-spear/spear13xx.c                    |   2 +-
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-spear13xx.c                  | 405 +++++++++++++++++++++
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-spear1310-miphy.c                  | 274 ++++++++++++++
 drivers/phy/phy-spear1340-miphy.c                  | 307 ++++++++++++++++
 21 files changed, 1211 insertions(+), 133 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear-misc.txt
 create mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear-miphy.txt
 create mode 100644 drivers/pci/host/pcie-spear13xx.c
 create mode 100644 drivers/phy/phy-spear1310-miphy.c
 create mode 100644 drivers/phy/phy-spear1340-miphy.c
