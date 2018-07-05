From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 14:40:11 +0200
Subject: [PATCH v4 14/14] arm64: dts: marvell: add CP110 ICU SEI subnode
In-Reply-To: <20180705124011.7661-1-miquel.raynal@bootlin.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
Message-ID: <20180705124011.7661-15-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICU handles several interrupt groups, each of them being a subpart
of the ICU node.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 823953e207e7..ab31ba20aa2a 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -160,6 +160,14 @@
 				interrupt-controller;
 				msi-parent = <&gicp>;
 			};
+
+			CP110_LABEL(icu_sei): interrupt-controller at 50 {
+				compatible = "marvell,cp110-icu-sei";
+				reg = <0x50 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				msi-parent = <&sei>;
+			};
 		};
 
 		CP110_LABEL(rtc): rtc at 284000 {
-- 
2.14.1
