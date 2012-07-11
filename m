From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:27 +0100
Subject: [PATCH 5/9] ARM: vexpress: Add missing SP804 interrupt in
 motherboard's DTS files
In-Reply-To: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1342013791-19516-6-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |    1 +
 arch/arm/boot/dts/vexpress-v2m.dtsi     |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 16076e2..142c72a 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -157,6 +157,7 @@
 			v2m_timer23: timer at 120000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x120000 0x1000>;
+				interrupts = <3>;
 			};
 
 			/* DVI I2C bus */
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index a6c9c7c..47ee307 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -156,6 +156,7 @@
 			v2m_timer23: timer at 12000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x12000 0x1000>;
+				interrupts = <3>;
 			};
 
 			/* DVI I2C bus */
-- 
1.7.9.5
