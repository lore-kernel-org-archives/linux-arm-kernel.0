From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:08 -0500
Subject: [PATCH 13/17] qcom: ipq4019: add i2c node to ipq4019 SoC and DK01
 device tree
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-14-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow boards to enable the I2C bus

CC: Sricharan R <srichara@qti.qualcomm.com>
Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 99e64f4..1937edf 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -25,6 +25,7 @@
 
 	aliases {
 		spi0 = &spi_0;
+		i2c0 = &i2c_0;
 	};
 
 	cpus {
@@ -126,6 +127,18 @@
 			status = "disabled";
 		};
 
+		i2c_0: i2c at 78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b7000 0x6000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
                 acc0: clock-controller at b088000 {
                         compatible = "qcom,kpss-acc-v1";
                         reg = <0x0b088000 0x1000>, <0xb008000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
