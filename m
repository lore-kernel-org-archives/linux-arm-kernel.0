From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Jun 2017 14:05:43 +0200
Subject: [PATCH v3 0/3] soc: amlogic: Add Amlogic SoC Information driver
Message-ID: <1497441946-24379-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic SoCs have a SoC information register for SoC type, package type and
revision information.
This patchset adds support for this register decoding and exposing with the
SoC bus infrastructure, with dt-bindings and DT node.

Changes since v2 at [2] :
 - Removed subnodes of socinfo node
 - Checks has-chip-id property and if node is enabled

Changes since v1 at [1] :
 - Switch DT representation to use regmap ans sub-node of a simple-mfd node
 - Updated DT, bindings and driver accordingly

[1] http://lkml.kernel.org/r/1490950079-10145-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1496742340-10307-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (3):
  dt-bindings: arm: amlogic: Add SoC information bindings
  ARM64: dts: meson-gx: Add SoC info register
  soc: Add Amlogic SoC Information driver

 Documentation/devicetree/bindings/arm/amlogic.txt |  29 ++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         |   6 +
 drivers/soc/Kconfig                               |   1 +
 drivers/soc/Makefile                              |   1 +
 drivers/soc/amlogic/Kconfig                       |  12 ++
 drivers/soc/amlogic/Makefile                      |   1 +
 drivers/soc/amlogic/meson-gx-socinfo.c            | 177 ++++++++++++++++++++++
 7 files changed, 227 insertions(+)
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c

-- 
1.9.1
