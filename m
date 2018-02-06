From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  6 Feb 2018 12:49:05 +0800
Subject: [PATCH v2 10/10] ARM: sun8i: h3: set the cpu-supply to VDD-CPUX on
 ALL-H3-CC H3 ver
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Message-ID: <20180206044905.30508-11-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ALL-H3-CC has a fixed VDD-CPUX voltage at 1.2V, which is supplied
by a regulator.

Set the CPU's cpu-supply property to the VDD-CPUX regulator.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v2.

 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index ca974d872357..02eb50b91a8f 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -112,6 +112,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &codec {
 	allwinner,audio-routing =
 		"Line Out", "LINEOUT",
-- 
2.15.1
