From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2012 16:13:57 +0200
Subject: [PATCH 5/5] arm: mvebu: add address decoding controller to the DT
In-Reply-To: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344003237-13575-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6b6b932..16cc82c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -63,6 +63,11 @@
 			       reg = <0xd0020300 0x30>;
 			       interrupts = <37>, <38>, <39>, <40>;
 		};
+
+		addr-decoding at d0020000 {
+			compatible = "marvell,armada-addr-decoding-controller";
+			reg = <0xd0020000 0x258>;
+		};
 	};
 };
 
-- 
1.7.9.5
