From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 06 Nov 2014 22:40:13 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <545C694D.1030204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sonymobile.com>

Update msm8974 dtsi for msm_serial to reflect msm_serial_probe()
getting line id from the serial alias.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/arch/arm/boot/dts/qcom-msm8974.dtsi
===================================================================
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -9,6 +9,10 @@
 	compatible = "qcom,msm8974";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		serial0 = &serial0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -189,7 +193,7 @@
 			reg = <0xfd8c0000 0x6000>;
 		};
 
-		serial at f991e000 {
+		serial0: serial at f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
 			interrupts = <0 108 0x0>;
