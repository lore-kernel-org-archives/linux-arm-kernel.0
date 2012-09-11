From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:30 +0200
Subject: [PATCH v4 17/17] arm: mvebu: add address decoding controller to the DT
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-18-git-send-email-thomas.petazzoni@free-electrons.com>
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
