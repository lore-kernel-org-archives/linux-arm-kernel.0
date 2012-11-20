From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:57:05 +0100
Subject: [PATCH 4/4] arm: mvebu: SATA support: board-level DT data for Armada
 370/XP boards
In-Reply-To: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353423425-20574-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Add the SATA device tree bindings for
- Armada XP evaluation board (DB-78460-BP)
- Armada 370 evaluation board (DB-88F6710-BP-DDR3)

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |    4 ++++
 arch/arm/boot/dts/armada-xp-db.dts  |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 4a31b03..cfc0807 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -34,5 +34,9 @@
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
+		sata at d00a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index b1fc728..e59f14f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -46,5 +46,9 @@
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
+		sata at d00a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
