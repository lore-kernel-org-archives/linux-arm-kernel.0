From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:30 +0100
Subject: [PATCH v3 13/13] ARM: dts: armada-375: Fixup ethernet child DT warning
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-14-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Child of mvpp2 ethernet do not have a reg property so the unit name
should not contain an address: remove them.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3e61c2dd1437..70243d2b8491 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -241,13 +241,13 @@
 				clock-names = "pp_clk", "gop_clk";
 				status = "disabled";
 
-				eth0: eth0 at c4000 {
+				eth0: eth0 {
 					interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <0>;
 					status = "disabled";
 				};
 
-				eth1: eth1 at c5000 {
+				eth1: eth1 {
 					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <1>;
 					status = "disabled";
-- 
2.10.2
