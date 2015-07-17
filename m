From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 17 Jul 2015 13:04:05 +0100
Subject: [PATCH 4/6] ARM: STi: stih407-family: Add nodes for Mailbox
In-Reply-To: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1437134647-28298-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies the Mailbox Controller nodes.  In order to
request channels, these nodes will be referenced by Mailbox
Client nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 838b812..c061d11 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset-controller/stih407-resets.h>
 #include <dt-bindings/interrupt-controller/irq-st.h>
+#include <dt-bindings/mailbox/mailbox.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -565,5 +566,38 @@
 						  <&phy_port2 PHY_TYPE_USB3>;
 			};
 		};
+
+		mailbox0: mailbox at 0  {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f00000 0x1000>;
+			interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+			#mbox-cells	= <3>;
+			mbox-name	= "a9";
+			status		= "okay";
+		};
+
+		mailbox1: mailbox at 1 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f01000 0x1000>;
+			#mbox-cells	= <3>;
+			mbox-name	= "st231_gp_1";
+			status		= "okay";
+		};
+
+		mailbox2: mailbox at 2 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f02000 0x1000>;
+			#mbox-cells	= <3>;
+			mbox-name	= "st231_gp_0";
+			status		= "okay";
+		};
+
+		mailbox3: mailbox at 3 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f03000 0x1000>;
+			#mbox-cells	= <3>;
+			mbox-name	= "st231_audio_video";
+			status		= "okay";
+		};
 	};
 };
-- 
1.9.1
