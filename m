From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 31 Mar 2017 10:47:56 +0200
Subject: [PATCH 0/3] soc: amlogic: Add Amlogic SoC Information driver
Message-ID: <1490950079-10145-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic SoCs have a SoC information register for SoC type, package type and
revision information.
This patchset adds support for this register decoding and exposing with the
SoC bus infrastructure, with dt-bindings and DT node.

Neil Armstrong (3):
  soc: Add Amlogic SoC Information driver
  dt-bindings: arm: amlogic: Add SoC information bindings
  ARM64: dts: meson-gx: Add SoC info register

 Documentation/devicetree/bindings/arm/amlogic.txt |  20 +++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         |   5 +
 drivers/soc/Kconfig                               |   1 +
 drivers/soc/Makefile                              |   1 +
 drivers/soc/amlogic/Kconfig                       |  12 ++
 drivers/soc/amlogic/Makefile                      |   1 +
 drivers/soc/amlogic/meson-gx-socinfo.c            | 158 ++++++++++++++++++++++
 7 files changed, 198 insertions(+)
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c

-- 
1.9.1
