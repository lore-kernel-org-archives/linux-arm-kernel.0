From: klaus.goger@theobroma-systems.com (Klaus Goger)
Date: Fri, 18 Aug 2017 21:34:40 +0200
Subject: [PATCH v2 0/5] arm64: dts: add RK3399-Q7
Message-ID: <20170818193445.47542-1-klaus.goger@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the devicetree for the Qseven module RK3399-Q7 and it's EVK baseboard.
See https://www.theobroma-systems.com/rk3399-q7/ for more information
about the module

As it uses fan535555 instead of syr82x that has slightly different
voltage settings we also overwrite the cpu_b cluster opp settings
from rk3399-opp.dtsi

This series also includes additional devicetree bindings to satisfy
checkpatch.

Two issues that have been observed with current linux-next:
 *  PCIe is not working due iommu_get_domain_for_dev always returning null.
 *  SD-Card detect only works if used as cd-gpio.


Changes in v2:
? split dts in a SoM dtsi and a dts for the baseboard
- use dashes in phandles
- use /delete-node/ before redefining opp-table1
- add comment why opp-table1 is redefined
- use generic node names
- remove deprecated regulator-compatible property
- add vqmmc property to sdmmc

Klaus Goger (5):
  dt-bindings: add vendor prefix for Theobroma Systems
  dt-bindings: add amc6821, isl1208 trivial bindings
  dt-bindings: add rk3399-q7 SoM
  arm64: dts: add RK3399-Q7 (Puma) SoM
  arm64: dts: add Haikou baseboard with RK3399-Q7 SoM

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../devicetree/bindings/trivial-devices.txt        |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 228 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 546 +++++++++++++++++++++
 6 files changed, 782 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi

-- 
2.11.0
