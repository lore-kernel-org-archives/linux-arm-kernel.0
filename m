From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  3 May 2016 19:52:17 +0200
Subject: [RFC PATCH 00/12] ARM: dts: exynos: Reorganize before adding Odroid
 XU board
Message-ID: <1462297949-13824-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I am in the middle (or beginning) of adding DTS for Odroid XU. This
patchset is a preparation for that. I still did not figure out two
things:
1. clock IDs, should we follow Exynos5420 (or maybe reuse entirely?)
   see patch 1.
2. sd0_rclk - see patch 5.


The Odroid XU board is based on Exynos5410: an octal-core design where
apparently only one cluster (big or little) could be active. The Exynos5410
is a first big.LITTLE design... with its early child issues (naughty kid).

The board itself is a mix between Odroid U3 (based on Exynos4412) and XU3.
For example it has usb3503+smsc95xx LAN as Odroid U3 so probably
same issues as U3 will happen (USB/LAN fails after TFTP boot). On the
other hand it has size, look (case) and most of components the same
as in XU3 and XU3-lite.

As for now you can boot it with Hardkernel U-Boot and SMDK5410 DTB.

Comments welcome!


BR,
Krzysztof


Krzysztof Kozlowski (12):
  dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
  dt-bindings: clock: Add PWM clock ID to Exynos5410
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

 arch/arm/boot/dts/exynos5.dtsi                  |  171 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi               | 1718 ++++++++++---------
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi       |   87 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |    6 +-
 arch/arm/boot/dts/exynos5410.dtsi               |  112 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi       |   12 +-
 arch/arm/boot/dts/exynos5420.dtsi               | 2058 +++++++++++------------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |   35 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |   35 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi |   50 +
 include/dt-bindings/clock/exynos5410.h          |   56 +-
 12 files changed, 2197 insertions(+), 2145 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi

-- 
2.5.0
