From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Oct 2017 16:58:23 +0200
Subject: [PATCH] ARM: dts: mvebu: pl310-cache disable double-linefill
Message-ID: <20171025145823.29262-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yan Markman <ymarkman@marvell.com>

Under heavy system stress mvebu SoC using Cortex A9 sporadically
encountered instability issues.

The "double linefill" feature of L2 cache was identified as causing
dependency between read and write which lead to the deadlock.

Especially, it was the cause of deadlock seen under heavy PCIe traffic,
as this dependency violates PCIE overtaking rule.

Fixes: c8f5a878e554 ("ARM: mvebu: use DT properties to fine-tune the L2 configuration")
Cc: stable at vger.kernel.org
Signed-off-by: Yan Markman <ymarkman@marvell.com>
Signed-off-by: Igal Liberman <igall@marvell.com>
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
[gregory.clement at free-electrons.com: reformulate commit log, add Armada
375 and add Fixes tag]
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 4 ++--
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 7225c7ce9a8d..2cb1bcd30976 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -178,9 +178,9 @@
 				reg = <0x8000 0x1000>;
 				cache-unified;
 				cache-level = <2>;
-				arm,double-linefill-incr = <1>;
+				arm,double-linefill-incr = <0>;
 				arm,double-linefill-wrap = <0>;
-				arm,double-linefill = <1>;
+				arm,double-linefill = <0>;
 				prefetch-data = <1>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7ff0811e61db..05e241fb91ad 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -143,9 +143,9 @@
 				reg = <0x8000 0x1000>;
 				cache-unified;
 				cache-level = <2>;
-				arm,double-linefill-incr = <1>;
+				arm,double-linefill-incr = <0>;
 				arm,double-linefill-wrap = <0>;
-				arm,double-linefill = <1>;
+				arm,double-linefill = <0>;
 				prefetch-data = <1>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index ea657071e278..5218bd2a248d 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -111,9 +111,9 @@
 				reg = <0x8000 0x1000>;
 				cache-unified;
 				cache-level = <2>;
-				arm,double-linefill-incr = <1>;
+				arm,double-linefill-incr = <0>;
 				arm,double-linefill-wrap = <0>;
-				arm,double-linefill = <1>;
+				arm,double-linefill = <0>;
 				prefetch-data = <1>;
 			};
 
-- 
2.14.2
