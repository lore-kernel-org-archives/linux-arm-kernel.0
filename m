From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 18:09:02 +0000
Subject: [PATCH 3/3] arm: orion5x: enable xor for orion5x platform
In-Reply-To: <1364062142-28117-1-git-send-email-alex@digriz.org.uk>
References: <1364062142-28117-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364062142-28117-4-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index e304f11..3944b9b 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -103,6 +103,25 @@
 			status = "disabled";
 		};
 
+		xor at 60900 {
+			compatible = "marvell,orion-xor";
+			reg = <0x60900 0x100
+			       0x60b00 0x100>;
+			status = "okay";
+
+			xor00 {
+			      interrupts = <30>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			};
+			xor01 {
+			      interrupts = <31>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			      dmacap,memset;
+			};
+		};
+
 		crypto at 90000 {
 			compatible = "marvell,orion-crypto";
 			reg = <0x90000 0x10000>,
-- 
1.7.10.4
