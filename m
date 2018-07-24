From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 24 Jul 2018 09:15:50 +0800
Subject: [PATCH 2/3] arm64: allwinner: dts: h6: add pinmux for MMC1
In-Reply-To: <20180724011551.49603-1-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
Message-ID: <20180724011551.49603-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC1 controller on H6, in the reference design and most third party
design, is used to connect SDIO Wi-Fi.

Add pinmux for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index cfa5fffcf62b..ba1a3a3e2149 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -134,6 +134,14 @@
 				bias-pull-up;
 			};
 
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_pins: mmc2-pins {
 				pins = "PC1", "PC4", "PC5", "PC6",
 				       "PC7", "PC8", "PC9", "PC10",
-- 
2.18.0
