From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 26 Mar 2013 21:44:47 +0000
Subject: [PATCHv3 2/4] arm: orion5x: add ehci bindings to dtsi
In-Reply-To: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364334289-19669-3-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orion5x SoC also includes a USB EHCI componment so lets add that
to the dtsi (disable by default incase the pins are not broken out).

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 7c2a326..6fbc5c0 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -74,6 +74,20 @@
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
