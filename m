From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  3 Mar 2015 10:41:21 +0000
Subject: [PATCH 1/3] ARM: STi: stih407-family: Add nodes for Mailbox
In-Reply-To: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1425379283-1567-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 0eb39d9..23916ac 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -12,6 +12,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		mailbox0 = &mailbox0;
+		mailbox1 = &mailbox1;
+		mailbox2 = &mailbox2;
+		mailbox3 = &mailbox3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -275,6 +282,66 @@
 			status = "disabled";
 		};
 
+		mailbox0: mailbox at 0  {
+			compatible = "st,stih407-mailbox";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#mbox-cells = <1>;
+			reg = <0x8f00000 0x1000>;
+			reg-names = "mbox-reg";
+			interrupts = <GIC_SPI 1 IRQ_TYPE_NONE>;
+			interrupt-names = "mb0_irq";
+			status = "okay";
+			st,name = "a9";
+			st,mbox-rx;
+			st,mbox-rx-id = <0>;
+			st,mbox-names = "chan0_a9";
+			st,mbox-chans = <0 0 0 0>;
+		};
+
+		mailbox1: mailbox at 1 {
+			compatible = "st,stih407-mailbox";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#mbox-cells = <1>;
+			reg = <0x8f01000 0x1000>;
+			reg-names = "mbox-reg";
+			status = "okay";
+			st,name = "st231_gp_1";
+			st,mbox-rx-id = <0>;
+			st,mbox-names = "chan0_gp1";
+			st,mbox-chans = <0 1 0 1>;
+		};
+
+		mailbox2: mailbox at 2 {
+			compatible = "st,stih407-mailbox";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#mbox-cells = <1>;
+			reg = <0x8f02000 0x1000>;
+			reg-names = "mbox-reg";
+			status = "okay";
+			st,name = "st231_gp_0";
+			st,mbox-rx-id = <0>;
+			st,mbox-names = "chan0_gp0";
+			st,mbox-chans = <4 0 4 0>;
+		};
+
+		mailbox3: mailbox at 3 {
+			compatible = "st,stih407-mailbox";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#mbox-cells = <1>;
+			reg = <0x8f03000 0x1000>;
+			reg-names = "mbox-reg";
+			status = "okay";
+			st,name = "st231_audio_video";
+			st,mbox-rx-id = <0>;
+			st,mbox-names = "chan0_video", "chan0_audio";
+			st,mbox-chans = <0 3 0 3>,
+					<16 3 16 3>;
+		};
+
 		st231_gp0: st231-gp0 at 0 {
 			compatible = "st,st231-rproc";
 			reg = <0x40000000 0x01000000>;
-- 
1.9.1
