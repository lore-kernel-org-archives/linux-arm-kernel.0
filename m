From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 30 Jun 2014 16:22:27 +0900
Subject: [PATCH 0/4] ARM: remove the sub-node and deprecated supports-highspeed
 property.
Message-ID: <1404112951-29467-1-git-send-email-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since used the mmc_of_parse(), didn't parse the sub-node.
So we can remove the sub-node, because almost SoC used the only one card per a host.
And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.

Jaehoon Chung (4):
  mmc: dw_mmc: modify the dt-binding for removing slot-node and
    supports-highspeed
  ARM: dts: exynos: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc
  ARM: dts: socfpga: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc
  ARM: dts: rockchip: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++---------
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
 arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
 arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
 arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++----------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   26 ++++++--------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   18 ++++----------
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++---------
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   16 +++---------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++---------
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   16 +++---------
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++---------
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    9 +++----
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
 arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
 20 files changed, 79 insertions(+), 197 deletions(-)

-- 
1.7.9.5
