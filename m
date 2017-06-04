From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Jun 2017 20:33:38 +0200
Subject: [PATCH 0/3] use the Meson8b clock controller driver on Meson8 SoCs
Message-ID: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the code from Amlogic's GPL kernel sources the clock controller
in the Meson8 (S802), Meson8b (S805) and Meson8m2 (S812) SoCs is very
similar.

a more detailed list of differences between the clock controller on each SoC
can be found in the description of the first patch.

This series adds new of_device_ids / compatibles for the Meson8 and Meson8m2
SoCs to the existing Meson8b clock controller driver (and updates the
documentation, Kconfig help and comments accordingly).
It also enables CONFIG_COMMON_CLK_MESON8B for MACH_MESON8.
Finally it adds the clock controller to meson8.dtsi and replaces the
static clk81 instance with the clk81 provided by the clock controller.

This is also the first preparation step for Meson8m2 SoC support by making
the clock controller available.
I am planning to post several follow-up series which will:
- add lots of missing devices to meson8.dtsi and meson8b.dtsi such as (but
  not limited to) PWM, USB controllers and PHYs, SAR ADC, HW random number
  generator and the SCU (Snoop Control Unit)
- add Meson8m2 SoC support
- once it's ready: the SDIO driver (allows connecting the SD card, SDIO wifi
  and eMMC flash)


Martin Blumenstingl (3):
  clk: meson: meson8b: add compatibles for Meson8 and Meson8m2
  arm: meson: select the clock controller for Meson8
  ARM: dts: meson8: add and use the real clock controller

 .../bindings/clock/amlogic,meson8b-clkc.txt        |  5 +++-
 arch/arm/boot/dts/meson8.dtsi                      | 32 +++++++++++-----------
 arch/arm/mach-meson/Kconfig                        |  1 +
 drivers/clk/meson/Kconfig                          |  6 ++--
 drivers/clk/meson/meson8b.c                        |  5 +++-
 5 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.13.0
