From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Jan 2015 12:59:20 +0900
Subject: [GIT PULL] Samsung DT updates for v3.20
Message-ID: <54C31898.1060906@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull Samsung DT updates for v3.20.
I checked to use signed tag in this time ;)

Thanks and if any problems, please let me know.

- Kukjin

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt

for you to fetch changes up to 23c76dc666471dce5ce71b620839d2465723a7c9:

  ARM: dts: Configure regulators for suspend on exynos Peach boards
(2015-01-15 00:30:49 +0900)

----------------------------------------------------------------
Samsung DT updates for v3.20

- exynos3250
  : add exynos_usbphy node and hsotg nodes

- exynos3250-rinato
  : enable usb
  : cleanup and use macro for gpio-keys
  : add fimd and Panel devices support

- exynos3250-monk
  : enable usb
  : cleanup and use macro for gpio-keys

- exynos5250-snow
  : add power and lid gpio-keys pinctrl

- exynos5420-peach-pit and exynos5800-peach-pi
  : configure regulators for suspend
  : set always on for USB webCam regulators
  : add lid GPIO key device

- exynos5422
  : add support new board Odroid XU3

- dt-bindings
  : add exynos-chipid

----------------------------------------------------------------
Beomho Seo (2):
      ARM: dts: remove unnecessary gpio-key nodes for exynos3250 boards
      ARM: dts: use macro in gpio keys for exynos3250 boards

Inki Dae (2):
      ARM: dts: add fimd device support for exynos3250-rinato
      ARM: dts: add Panel device support for exynos3250-rinato

Jaewon Kim (4):
      ARM: dts: Add exynos_usbphy node for exynos3250
      ARM: dts: Add hsotg node for exynos3250
      ARM: dts: Enable USB node for exynos3250-rinato
      ARM: dts: Enable USB node for exynos3250-monk

Javier Martinez Canillas (4):
      ARM: dts: Add power and lid GPIO keys pinctrl for exynos5250-snow
      ARM: dts: Add lid GPIO key device node for Peach boards
      ARM: dts: Set Peach boards USB WebCam regulators to always on
      ARM: dts: Configure regulators for suspend on exynos Peach boards

Pankaj Dubey (1):
      Documentation: dt-bindings: add exynos-chipid binding information

Sjoerd Simons (1):
      ARM: dts: Add dts file for Odroid XU3 board

 .../bindings/arm/samsung/exynos-chipid.txt         |  12 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos3250-monk.dts              |  15 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  85 +++++-
 arch/arm/boot/dts/exynos3250.dtsi                  |  21 ++
 arch/arm/boot/dts/exynos5250-snow.dts              |  16 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 100 ++++++-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 332
+++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 101 ++++++-
 9 files changed, 675 insertions(+), 8 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3.dts
