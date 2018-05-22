From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 22 May 2018 11:40:42 +0200
Subject: [PATCH v2 16/16] arm64: dts: marvell: add CP110 ICU SEI subnode
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Message-ID: <20180522094042.24770-17-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICU handles several interrupt groups, each of them being a subpart
of the ICU node.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 5637ff2601c9..0038a922e7db 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -154,6 +154,13 @@
 				interrupt-controller;
 				msi-parent = <&gicp>;
 			};
+
+			CP110_LABEL(icu_sei): icu-sei {
+				compatible = "marvell,cp110-icu-sei";
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				msi-parent = <&sei>;
+			};
 		};
 
 		CP110_LABEL(rtc): rtc at 284000 {
-- 
2.14.1
