From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 25 Jan 2017 14:19:30 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7795: Mark EthernetAVB device node disabled
In-Reply-To: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
References: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1485350371-16091-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTS, and overridden by board-specific DTSes where needed.

Fixes: a92843c8a6f8c039 ("arm64: dts: r8a7795: add EthernetAVB device node")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
r8a7795-salvator-x.dts and r8a7795-h3ulcb.dts already have the override.

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8b030c323c10488d..337061b8e99ec738 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -566,6 +566,7 @@
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		can0: can at e6c30000 {
-- 
1.9.1
