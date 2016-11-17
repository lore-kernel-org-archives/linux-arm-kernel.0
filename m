From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:02 +0100
Subject: [PATCH v3 13/19] ARM: dts: armada-370-xp: Fixup l2-cache DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-14-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2-cache which is either an aurora-outer-cache or an aurora-system-cache
has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 40d1a73d0967..0308783fa89a 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -131,7 +131,7 @@
 		};
 
 		internal-regs {
-			L2: l2-cache {
+			L2: l2-cache at 8000 {
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 175253e7335e..fddec79a9832 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -82,7 +82,7 @@
 				reg = <0x1400 0x500>;
 			};
 
-			L2: l2-cache {
+			L2: l2-cache at 8000 {
 				compatible = "marvell,aurora-system-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
-- 
2.10.2
