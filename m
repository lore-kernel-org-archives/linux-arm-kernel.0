From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 12 Jan 2016 22:07:33 +0200
Subject: [PATCH 2/2] ARM: DTS: kirkwood-openrd: fix SD slot default
 configuration
In-Reply-To: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
References: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1452629253-21748-2-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SD card slot was enabled by default with legacy booting.
It does not work anymore with DT boot. Fix by providing GPIO configuration
that matches the old default.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/kirkwood-openrd.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
index 2a3dafd..f65b727 100644
--- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
+++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
@@ -65,6 +65,14 @@
 			status = "okay";
 			cd-gpios = <&gpio0 29 9>;
 		};
+		gpio at 10140 {
+			p2 {
+				gpio-hog;
+				gpios = <2 GPIO_ACTIVE_HIGH>;
+				output-high; /* Select SD by default */
+				line-name = "SelUARTorSD";
+			};
+		};
 	};
 };
 
-- 
2.4.0
