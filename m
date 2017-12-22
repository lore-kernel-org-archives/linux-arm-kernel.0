From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:18 +0100
Subject: [PATCH 07/11] arm64: dts: renesas: r8a7796: add reg properties to
 pciec[01] nodes
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <4316989537a6ed530807244fd2b69f274bf195ff.1513936761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reg properties to pciec[01] placeholder nodes

This is to stop the compiler complaining as follows:
$ make
...
  DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 49c5893f8a35..a339047acdc7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1758,10 +1758,12 @@
 		};
 
 		pciec0: pcie at fe000000 {
+			reg = <0 0xfe000000 0 0x80000>;
 			/* placeholder */
 		};
 
 		pciec1: pcie at ee800000 {
+			reg = <0 0xee800000 0 0x80000>;
 			/* placeholder */
 		};
 
-- 
2.11.0
