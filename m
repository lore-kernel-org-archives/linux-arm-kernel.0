From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 11:13:25 +0200
Subject: [PATCH 0/3] clk: Add Meson GXBB Always-On Reset + Clocks
Message-ID: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXBB SoC has an Always-On part that contains pairs on
clocks and reset controls in a single memory mapped control register.
Add a separate clocks and reset node with the corresponding driver
exporting clock nodes and a reset controller.

Neil Armstrong (3):
  clk: meson: Add GXBB AO Clock and Reset controller driver
  dt-bindings: clock: reset: Add GXBB AO Clock and Reset Bindings
  ARM64: dts: meson-gxbb: Add GXBB AO Clock and Reset node

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  45 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   9 +
 drivers/clk/meson/Makefile                         |   2 +-
 drivers/clk/meson/gxbb-aoclk.c                     | 203 +++++++++++++++++++++
 include/dt-bindings/clock/gxbb-aoclkc.h            |  66 +++++++
 include/dt-bindings/reset/gxbb-aoclkc.h            |  66 +++++++
 6 files changed, 390 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 drivers/clk/meson/gxbb-aoclk.c
 create mode 100644 include/dt-bindings/clock/gxbb-aoclkc.h
 create mode 100644 include/dt-bindings/reset/gxbb-aoclkc.h

-- 
2.7.0
