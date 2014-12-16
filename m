From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 22:24:07 +0100
Subject: [GIT PULL 2/3] ARM: SoC DT updates for 3.19, part 2
In-Reply-To: <1472557.DTsj0nlvTo@wuerfel>
References: <5499732.TPqbyGxy2W@wuerfel> <1472557.DTsj0nlvTo@wuerfel>
Message-ID: <4321166.6UpSDjLxLY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the broken subject line in the previous mail, this has the
same contents with the right subject.

8<-------
The following changes since commit 8918465163171322c77a19d5258a95f56d89d2e4:

  memory: Add NVIDIA Tegra memory controller support (2014-12-04 16:11:47 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/dt2-for-linus

for you to fetch changes up to 1d5f497d87c7d960c27cdc40e7563b0ae88387d3:

  Merge tag 'tegra-for-3.19-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/dt2 (2014-12-04 17:21:49 +0100)

----------------------------------------------------------------
ARM: SoC DT updates for 3.19, part 2

This is a follow-up to the early ARM SoC DT changes, with additional
content that has external dependencies:

* The Tegra IOMMU DT support depends on changes from the iommu
  tree, plus the contents of the arm-soc drivers branch
* The MVEBU PHY support depends on changes from the phy tree
* The AT91 DT support depends on changes from the RTC and
  DMA-slave trees

All of these changes just enable additional devices for
existing platforms.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91/dt: at91sam9rl: add rtc

Arnd Bergmann (6):
      Merge branch 'topic/at_xdmac' of git://git.infradead.org/users/vkoul/slave-dma into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt2
      Merge tag 'v3.18-rc4' into next/dt2
      Merge tag 'depends/phy-dt-header' into next/dt2
      Merge tag 'mvebu-dt-usb-phy-3.19-3' of git://git.infradead.org/linux-mvebu into next/dt2
      Merge tag 'tegra-for-3.19-dt' of git://git.kernel.org/.../tegra/linux into next/dt2

Boris Brezillon (5):
      ARM: at91/dt: add RTT nodes to at91 dtsis
      ARM: at91/dt: add GPBR nodes
      ARM: at91/dt: enable the RTT block on the sam9g20ek board
      ARM: at91/dt: enable the RTT block on the at91sam9m10g45ek board
      ARM: at91/dt: at91sam9g45: add ISI node

Gregory CLEMENT (2):
      ARM: mvebu: add Device Tree description of USB cluster controller on Armada 375
      ARM: mvebu: add PHY support to the dts for the USB controllers on Armada 375

Jason Cooper (1):
      Merge tag 'tags/phy-dt-header' into mvebu/dt-usb_phy

Ludovic Desroches (2):
      ARM: at91/dt: sama5d4: use macro instead of numeric value
      ARM: at91/dt: sama5d4: add DMA support

Nicolas Ferre (3):
      Merge branch 'at91-3.19-dt' into at91-3.19-dt2
      Merge branch 'topic/at_xdmac' of git://git.infradead.org/users/vkoul/slave-dma into at91-3.19-dt2
      ARM: at91: fix GPLv2 wording

Sean Paul (1):
      ARM: tegra: Add APB_MISC_GP as a MIPI pad control bank

Thierry Reding (7):
      Merge branch 'for-3.19/iommu' into for-3.19/dt
      ARM: tegra: Add memory controller support for Tegra30
      ARM: tegra: Add memory controller support for Tegra114
      ARM: tegra: Add memory controller support for Tegra124
      ARM: tegra: Enable IOMMU for display controllers on Tegra30
      ARM: tegra: Enable IOMMU for display controllers on Tegra114
      ARM: tegra: Enable IOMMU for display controllers on Tegra124

 arch/arm/boot/dts/armada-375.dtsi           | 11 +++++
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  4 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 14 ++++++
 arch/arm/boot/dts/at91sam9261.dtsi          | 14 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi          | 21 ++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 14 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          | 46 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  9 ++++
 arch/arm/boot/dts/at91sam9rl.dtsi           | 21 ++++++++
 arch/arm/boot/dts/sama5d4.dtsi              | 75 +++++++++++++++++++++++++++--
 arch/arm/boot/dts/tegra114.dtsi             | 23 +++++----
 arch/arm/boot/dts/tegra124.dtsi             | 19 +++++++-
 arch/arm/boot/dts/tegra30.dtsi              | 25 +++++-----
 13 files changed, 267 insertions(+), 29 deletions(-)
