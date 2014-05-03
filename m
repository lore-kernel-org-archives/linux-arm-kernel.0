From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:13 +0200
Subject: [PATCH v2 3/9] ARM: Kirkwood: Add node for audio codec
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the audio codec via a DT node.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-t5325.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 0bd70d928c69..dbb730642543 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -127,6 +127,14 @@
 
 		i2c at 11000 {
 			status = "okay";
+
+			alc5621: alc5621 at 1a {
+				compatible = "realtek,alc5621";
+				reg = <0x1a>;
+				#sound-dai-cells = <0>;
+				add-ctrl = <0x3700>;
+				jack-det-ctrl = <0x4810>;
+			};
 		};
 
 		serial at 12000 {
-- 
2.0.0.rc0
