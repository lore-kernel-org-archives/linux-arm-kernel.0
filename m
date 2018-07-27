From: manu@freebsd.org (Emmanuel Vadot)
Date: Fri, 27 Jul 2018 13:52:05 +0200
Subject: [PATCH v3 4/4] arm64: dts: allwinner: h5: Add SID for H5
In-Reply-To: <20180727115205.20955-1-manu@freebsd.org>
References: <20180727115205.20955-1-manu@freebsd.org>
Message-ID: <20180727115205.20955-4-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H5 SoC have a SID controller like the others Allwinner SoC.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 62d646baac3c..9838acaeea58 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -92,6 +92,13 @@
 			     <GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	soc {
+		sid: eeprom at 1c14000 {
+			compatible = "allwinner,sun50i-h5-sid";
+			reg = <0x1c14000 0x400>;
+		};
+	};
 };
 
 &ccu {
-- 
2.18.0
