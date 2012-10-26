From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Oct 2012 14:30:49 +0200
Subject: [PATCH V2 4/4] arm: mvebu: adding SATA support: dt binding for Armada
 370/XP boards
In-Reply-To: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1351254650-26861-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SATA device tree bindings for
- Armada XP evaluation board (DB-78460-BP)
- Armada 370 evaluation board (DB-88F6710-BP-DDR3)

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/boot/dts/armada-370-db.dts |    4 ++++
 arch/arm/boot/dts/armada-xp-db.dts  |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 4a31b03..060e5ba 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -34,5 +34,9 @@
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
+		sata at d00a0000 {
+                        nr-ports = <2>;
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index b1fc728..375436b 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -46,5 +46,9 @@
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
+		sata at d00a0000 {
+                        nr-ports = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
