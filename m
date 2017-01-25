From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 25 Jan 2017 14:19:31 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7796: Mark EthernetAVB device node disabled
In-Reply-To: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
References: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1485350371-16091-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTS, and overridden by board-specific DTSes where needed.

Fixes: 8e8b9eaef8fb05d9 ("arm64: dts: renesas: r8a7796: Add EthernetAVB instance")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
r8a7796-salvator-x.dts already has the override.

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 82c5ef1b60659944..f7120cdedd0d67b2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -472,6 +472,7 @@
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif2: serial at e6e88000 {
-- 
1.9.1
