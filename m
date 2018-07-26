From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 26 Jul 2018 10:19:00 +0200
Subject: [GIT PULL] ARM: mediatek: 64-bit DT updates for v4.19
In-Reply-To: <02b45906-ace0-bf49-7ccc-c9827e919d7c@gmail.com>
References: <02b45906-ace0-bf49-7ccc-c9827e919d7c@gmail.com>
Message-ID: <3d66f9bc-48b5-00f2-c8eb-838f0ded5d90@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Hi Arnd,

This is the second attempt to send the pull request, as in the first one I sent
the branch instead of the tag.

Please have a look.
Regards,
Matthias

---

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.18-next-dts64

for you to fetch changes up to a873996921296ad74941017bf00884f14e10dffd:

  arm64: dts: Add Mediatek X20 Development Board support (2018-07-20 17:46:46 +0200)

----------------------------------------------------------------
- mt7622:
- add EINT support
- add gpio-ranges property to pinctrl
- add earlycon to rfb1 to find boot errros more easily
- fix uart clock
- add iommu and smi bindings

- mt6797:
- add support for the 96 board x20 development board

- fix cooling-cells of mt7622 and mt8173

----------------------------------------------------------------
Manivannan Sadhasivam (2):
      dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
      arm64: dts: Add Mediatek X20 Development Board support

Ryder Lee (1):
      arm64: dts: mt7622: update a clock property for UART0

Sean Wang (3):
      arm64: dts: mt7622: add EINT support to pinctrl
      arm64: dts: mt7622: use gpio-ranges to pinctrl device
      arm64: dts: mt7622: add earlycon to mt7622-rfb1 board

Viresh Kumar (1):
      arm64: dts: mediatek: Add missing cooling device properties for CPUs

Yong Wu (1):
      dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI

 Documentation/devicetree/bindings/arm/mediatek.txt |  3 +
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
 .../memory-controllers/mediatek,smi-common.txt     |  6 +-
 .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts    | 33 ++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  4 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 12 ++-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  2 +
 include/dt-bindings/memory/mt2712-larb-port.h      | 95 ++++++++++++++++++++++
 10 files changed, 157 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
 create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
