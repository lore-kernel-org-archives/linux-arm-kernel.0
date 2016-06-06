From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:32 +0200
Subject: [GIT PULL 7/8] ARM: dts: exynos: Topic branch with Odroid XU for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This topic branch pulls external clk dependency (provided by Sylwester
Nawrocki).

Expected annoying conflict with DT changes here (please see the email 0/8).


Best regards,
Krzysztof


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-odroid-xu-4.8

for you to fetch changes up to b8bd7e23bb0be762c39510497c931066dc62e62f:

  ARM: dts: exynos: Add watchdog and Security SubSystem to Exynos5410 (2016-06-06 13:20:57 +0200)

----------------------------------------------------------------
Topic branch for adding Exynos 5410 Odroid XU board for v4.8.

This brings support for Hardkernel's Odroid XU board.  It was the first
design with big.LITTLE SoC from Samsung: Exynos5410.  The board is not
very popular.  Newer XU3 and XU4 got more attention.

Board details:
1. Exynos5410 octa-core (A15+A7, however as of now only one cluster is
   enabled),
2. 2 GB DDR3 RAM,
3. PowerVR SGX544MP3 GPU (not enabled in DTS),
4. USB 3.0 Host x 1, USB 3.0 OTG x 1, USB 2.0 Host x 4,
5. HDMI 1.4a, MIPI DSI and Display Port (Display Port not on all of
   revisions though),
6. eMMC 4.5 and microSD slots.

----------------------------------------------------------------
Krzysztof Kozlowski (30):
      dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
      dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
      dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410
      Merge tag 'clk-v4.8-exynos5410-dt' of git://linuxtv.org/snawrocki/samsung into for-v4.8/dts-exynos5410-odroid-xu
      ARM: dts: exynos: Replace deprecated hsi2c compatible on Exynos5420
      ARM: dts: exynos: Re-order alphabetically Exynos5420 SD0/SD1 pinctrl nodes
      ARM: dts: exynos: Enable CLKOUT on Exynos5410
      ARM: dts: exynos: Use lowercase for Exynos5410 CPU node labels
      ARM: dts: exynos: Configure Exynos5410 pinctrl for eMMC and SD card
      ARM: dts: exynos: Split Odroid XU3 LEDs to separate DTSI
      ARM: dts: exynos: Move common nodes to exynos5.dtsi
      ARM: dts: exynos: Prepare for inclusion of exynos5.dtsi in exynos5410.dtsi
      ARM: dts: exynos: Use phandle to get parent node in exynos5250-snow
      ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc
      ARM: dts: exynos: Include common exynos5 in exynos5410.dtsi
      ARM: dts: exynos: Enable UART3 on Exynos5410
      ARM: dts: exynos: MCT is not an interrupt controller and extend length of iomap
      ARM: dts: exynos: Move common Exynos5410/542x/5800 nodes to new DTSI
      ARM: dts: exynos: Add USB to Exynos5410
      ARM: dts: exynos: Add initial support for Odroid XU board
      ARM: dts: exynos: Move HSI2C nodes to exynos54xx.dtsi
      ARM: dts: exynos: Add I2C, PWM and UART pinctrl to Exynos5410
      ARM: dts: exynos: Add RTC and I2C to Exynos5410
      dt-bindings: clock: Add TMU clock ID to Exynos5410
      dt-bindings: clock: Add watchdog and SSS clock IDs to Exynos5410
      ARM: dts: exynos: Interrupt for USB DWC3-1 differs between Exynos5420 and 5410
      Merge tag 'clk-v4.8-exynos5410-dt-2' of git://linuxtv.org/snawrocki/samsung into for-v4.8/dts-exynos5410-odroid-xu
      ARM: dts: exynos: Add Thermal Management Unit to Exynos5410
      ARM: dts: exynos: Configure PWM, usb3503, PMIC and thermal on Odroid XU board
      ARM: dts: exynos: Add watchdog and Security SubSystem to Exynos5410

 .../bindings/arm/samsung/samsung-boards.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5.dtsi                     |  215 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi                  | 1701 ++++++------
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  580 ++++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |  210 ++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    6 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  333 ++-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   12 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 2768 +++++++++-----------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   35 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   35 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |   50 +
 arch/arm/boot/dts/exynos54xx.dtsi                  |  199 ++
 include/dt-bindings/clock/exynos5410.h             |   76 +-
 16 files changed, 3593 insertions(+), 2631 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
 create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi
