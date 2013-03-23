From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 18:09:01 +0000
Subject: [PATCH 2/3] arm: orion5x: add ehci bindings to dtsi
In-Reply-To: <1364062142-28117-1-git-send-email-alex@digriz.org.uk>
References: <1364062142-28117-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364062142-28117-3-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 9bde027..e304f11 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -72,6 +72,20 @@
 			status = "okay";
 		};
 
+		ehci at 50000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0x50000 0x1000>;
+			interrupts = <17>;
+			status = "disabled";
+		};
+
+		ehci at a0000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0xa0000 0x1000>;
+			interrupts = <12>;
+			status = "disabled";
+		};
+
 		sata at 80000 {
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
-- 
1.7.10.4
