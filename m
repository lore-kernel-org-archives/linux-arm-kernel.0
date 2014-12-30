From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Dec 2014 13:43:44 +0100
Subject: [PATCH 3/6] ARM: mvebu: fix compatible strings of MBus on Armada 375
 and Armada 38x
In-Reply-To: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1419943428-18491-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the special handling of window 13 on Armada 375 and Armada 38x
(similar to Armada XP), the MBus hardware block is *not* compatible
with the one used on Armada 370. Using the Armada 370 compatible
string on Armada 375 and 38x will lead to a non-working device if
window 13 ends up being used.

Fixes: 4de59085091 ("ARM: mvebu: add Device Tree description of the Armada 375 SoC")
Fixes: 0d3d96ab005 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 50096d3..126bf7e 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -63,7 +63,7 @@
 	};
 
 	soc {
-		compatible = "marvell,armada375-mbus", "marvell,armada370-mbus", "simple-bus";
+		compatible = "marvell,armada375-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 74391da..7d8295c 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -31,8 +31,7 @@
 	};
 
 	soc {
-		compatible = "marvell,armada380-mbus", "marvell,armada370-mbus",
-			     "simple-bus";
+		compatible = "marvell,armada380-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
-- 
2.1.0
