From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 20:30:29 +0800
Subject: [PATCH 9/9] ARM: dts: sun8i: enable audio on Lichee Pi Zero Dock
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Message-ID: <20170225123029.55939-9-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Dock board of Lichee Pi Zero features a 3.5mm Headphone Jack and an
onboard MIC.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index 68c114d6b939..d0f17bcaeaab 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -47,3 +47,12 @@
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
 		     "allwinner,sun8i-v3s";
 };
+
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
-- 
2.11.1
