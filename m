From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:44 +0100
Subject: [[PATCH v2] 5/8] ARM: dts: STi: stih407-family: Add nodes for Mailbox
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies the Mailbox Controller nodes.  In order to
request channels, these nodes will be referenced by Mailbox
Client nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index eb2601f..680b7c1 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -714,5 +714,38 @@
 			clocks          = <&clk_sysin>;
 			status		= "okay";
 		};
+
+		mailbox0: mailbox at 8f00000  {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f00000 0x1000>;
+			interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+			#mbox-cells	= <2>;
+			mbox-name	= "a9";
+			status		= "okay";
+		};
+
+		mailbox1: mailbox at 8f01000 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f01000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_gp_1";
+			status		= "okay";
+		};
+
+		mailbox2: mailbox at 8f02000 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f02000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_gp_0";
+			status		= "okay";
+		};
+
+		mailbox3: mailbox at 8f03000 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f03000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_audio_video";
+			status		= "okay";
+		};
 	};
 };
-- 
2.8.0
