From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 18:06:07 +0800
Subject: [PATCH v3 9/9] ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock
 board
In-Reply-To: <20170524100607.29790-1-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
Message-ID: <20170524100607.29790-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Lichee Pi Zero Dock board has an audio jack and an onboard MIC.

Enable them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..80f477738668 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -55,6 +55,15 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC1", "Mic",
+		"Mic",  "HBIAS";
+	status = "okay";
+};
+
 &mmc1 {
 	broken-cd;
 	bus-width = <4>;
-- 
2.12.2
