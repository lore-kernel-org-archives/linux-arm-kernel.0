From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Jun 2017 11:45:37 +0200
Subject: [PATCH v2 0/3] soc: amlogic: Add Amlogic SoC Information driver
Message-ID: <1496742340-10307-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic SoCs have a SoC information register for SoC type, package type and
revision information.
This patchset adds support for this register decoding and exposing with the
SoC bus infrastructure, with dt-bindings and DT node.

Changes since v1 at [1] :
 - Switch DT representation to use regmap ans sub-node of a simple-mfd node
 - Updated DT, bindings and driver accordingly

Neil Armstrong (3):
  dt-bindings: arm: amlogic: Add SoC information bindings
  ARM64: dts: meson-gx: Add SoC info register
  soc: Add Amlogic SoC Information driver

 Documentation/devicetree/bindings/arm/amlogic.txt |  32 ++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         |   9 ++
 drivers/soc/Kconfig                               |   1 +
 drivers/soc/Makefile                              |   1 +
 drivers/soc/amlogic/Kconfig                       |  12 ++
 drivers/soc/amlogic/Makefile                      |   1 +
 drivers/soc/amlogic/meson-gx-socinfo.c            | 169 ++++++++++++++++++++++
 7 files changed, 225 insertions(+)
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c

-- 
1.9.1
