From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:26 +0300
Subject: [PATCH v2 11/20] ARM: DTS: am437x-gp-evm: Add node for tlv320aic3106
 audio codec
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-12-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Analog audio is using this codec on the board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index e0ce7ce0a201..32446c079fd3 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -510,6 +510,18 @@
 			};
 		};
 	};
+
+	tlv320aic3106: tlv320aic3106 at 1b {
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&evm_v3_3d>; /* V3_3D -> <tps63031> EN: V1_8D -> VBAT */
+		AVDD-supply = <&evm_v3_3d>; /* v3_3AUD -> V3_3D -> ... */
+		DRVDD-supply = <&evm_v3_3d>; /* v3_3AUD -> V3_3D -> ... */
+		DVDD-supply = <&ldo1>; /* V1_8D -> LDO1 */
+	};
 };
 
 &epwmss0 {
-- 
2.4.5
