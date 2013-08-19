From: markus.mayer@linaro.org (Markus Mayer)
Date: Mon, 19 Aug 2013 11:59:18 -0700
Subject: [PATCH v4 0/3] ARM: bcm281xx: GPIO driver
Message-ID: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the GPIO driver, and its device tree bindings,
for the Broadcom bcm281xx family of chips.

Changes since v3:

- removed global variables
- removed inline functions for register access
- removed bcm_kona_gpio_request() & bcm_kona_gpio_free()
- removed bcm_kona_gpio_remove() for now
- fixed MODULE_DEVICE_TABLE
- added chip-specific compatibility value to device tree binding
- added missing "#interrupt-cells = <2>;" to device tree binding
- device tree binding document comes with code patch (rather than DT patch)
- turn on GPIO by defaulting to 'y', not by selecting based on platform
- use symbolic values in device tree file
- some additional clean-up & error-checking

Markus Mayer (3):
  ARM: bcm281xx: Add GPIO driver
  ARM: bcm281xx: Enable GPIO driver
  ARM: bcm281xx: Device Tree bindings for GPIO driver

 .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   43 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |   16 +
 arch/arm/mach-bcm/Kconfig                          |    1 -
 drivers/gpio/Kconfig                               |    7 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bcm-kona.c                       |  658 ++++++++++++++++++++
 6 files changed, 725 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
 create mode 100644 drivers/gpio/gpio-bcm-kona.c

-- 
1.7.9.5
