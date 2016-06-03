From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  3 Jun 2016 10:46:58 +0200
Subject: [PATCH 0/3] hw_random: Add Amlogic Meson SoCs Random Genenerator
 driver
Message-ID: <1464943621-18278-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Amlogic Meson SoCs Hardware Random generator as a hw_random char driver.
The generator is a single 32bit wide register.
Also adds the Meson GXBB SoC DTSI node and corresponding DT bindings.

Neil Armstrong (3):
  char: hw_random: Add Amlogic Meson Hardware Random Generator
  dt-bindings: hwrng: Add Amlogic Meson Hardware Random Generator
    bindings
  ARM64: dts: meson-gxbb: Add Hardware Random Generator node

 .../devicetree/bindings/rng/amlogic,meson-rng.txt  |  14 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   5 +
 drivers/char/hw_random/Kconfig                     |  13 +++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/meson-rng.c                 | 128 +++++++++++++++++++++
 5 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
 create mode 100644 drivers/char/hw_random/meson-rng.c

-- 
2.7.0
