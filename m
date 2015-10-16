From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 16 Oct 2015 08:21:29 +0100
Subject: [PATCH v4 3/5] ARM: STi: stih407-family: Add nodes for Mailbox
In-Reply-To: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
References: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1444980091-16728-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies the Mailbox Controller nodes.  In order to
request channels, these nodes will be referenced by Mailbox
Client nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index ae05277..0e5d3ea 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -610,5 +610,38 @@
 			clocks		= <&clk_sysin>;
 			st,pwm-num-chan = <4>;
 		};
+
+		mailbox0: mailbox at 0  {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f00000 0x1000>;
+			interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+			#mbox-cells	= <2>;
+			mbox-name	= "a9";
+			status		= "okay";
+		};
+
+		mailbox1: mailbox at 1 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f01000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_gp_1";
+			status		= "okay";
+		};
+
+		mailbox2: mailbox at 2 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f02000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_gp_0";
+			status		= "okay";
+		};
+
+		mailbox3: mailbox at 3 {
+			compatible	= "st,stih407-mailbox";
+			reg		= <0x8f03000 0x1000>;
+			#mbox-cells	= <2>;
+			mbox-name	= "st231_audio_video";
+			status		= "okay";
+		};
 	};
 };
-- 
1.9.1
