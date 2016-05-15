From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:41 +0200
Subject: [PATCH v4 00/22] ARM: dts: exynos: Add initial support for Odroid XU
Message-ID: <1463343243-26429-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Patchset adds necessary clocks, reorganizes existing stuff and finally
adds Odroid XU support.


Changes since v3
================
1. Get rid of 5 patches changing the fin_pll after talk with Tomasz
   Figa. The existing definition of oscillator in exynos5410.dtsi
   is preferred over solution chosen for Exynos5420.
   This simplifies also the merging strategy.
2. Add tags from Javier (tested and reviewed).

Patchset is available at my private repo @github:
https://github.com/krzk/linux.git for-next/odroid-xu-v4
(I have some more changes coming but I think it is easier for
reviewers if the patchset does not grow infinitely)


Changes since v2
================
1. Got global-ack from Stephen for the clock changes. I think merging
   everything through arm-soc might be the easiest but:
   a. In such case I will prepare a tag with clock changes,
   b. Anyway I will wait for response from Sylwester and Tomasz.
2. Applied comments from Javier and added his Reviewed-by.
3. Patch 22: added ack from Rob.
4. Minor improvements in existing patches.
5. Five new patches at the end: 23-27 (not reviewed yet).
   Some of them could be squashed with existing ones but existing
   changes got reviews. Although the final Odroid XU DTS works fine but
   in general this is still work-in-progress so I suspect it will grow.
   I am releasing it early following Linux concept. :)


Changes since v1
================
1. A lot of new patches.
2. Removed some TODO notes (eMMC 4.5 so no RCLK pin).
3. New clocks, more reorganization.
4. New common DTSI: exynos54xx.dtsi. I know, it is getting more
   and more complicated but this might help removing duplications
   and keeping everything under control.



Merging strategy
================
The clock changes can go to clock tree. ARM changes to samsung-soc tree.
Please provide me a tag with include/dt-bindings/clock commits so I can
merge it.


Best regards,
Krzysztof

Krzysztof Kozlowski (22):
  dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
  dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
  clk: samsung: exynos5410: Add serial3, USB and PWM clocks
  ARM: dts: exynos: Re-order alphabetically Exynos5420 SD0/SD1 pinctrl
    nodes
  ARM: dts: exynos: Use lowercase for Exynos5410 CPU node labels
  ARM: dts: exynos: Configure Exynos5410 pinctrl for eMMC and SD card
  ARM: dts: exynos: Split Odroid XU3 LEDs to separate DTSI
  ARM: dts: exynos: Move common nodes to exynos5.dtsi
  ARM: dts: exynos: Prepare for inclusion of exynos5.dtsi in
    exynos5410.dtsi
  ARM: dts: exynos: Use phandle to get parent node in exynos5250-snow
  ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc
  ARM: dts: exynos: Include common exynos5 in exynos5410.dtsi
  ARM: dts: exynos: Enable UART3 on Exynos5410
  ARM: dts: exynos: MCT is not an interrupt controller and extend length
    of iomap
  ARM: dts: exynos: Move common Exynos5410/542x/5800 nodes to new DTSI
  ARM: dts: exynos: Add USB to Exynos5410
  ARM: dts: exynos: Add initial support for Odroid XU board
  dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410
  clk: samsung: exynos5410: Add I2C, HSI2C and RTC clocks
  ARM: dts: exynos: Move HSI2C nodes to exynos54xx.dtsi
  ARM: dts: exynos: Add I2C, PWM and UART pinctrl to Exynos5410
  ARM: dts: exynos: Add RTC and I2C to Exynos5410

 .../bindings/arm/samsung/samsung-boards.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5.dtsi                     |  215 ++-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi                  | 1701 ++++++++---------
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  121 ++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |  210 +++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    6 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  267 +--
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   12 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 1992 +++++++++-----------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   35 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   35 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |   50 +
 arch/arm/boot/dts/exynos54xx.dtsi                  |  188 ++
 drivers/clk/samsung/clk-exynos5410.c               |   45 +
 include/dt-bindings/clock/exynos5410.h             |   73 +-
 17 files changed, 2734 insertions(+), 2220 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
 create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi

-- 
2.5.0
