From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 15:26:44 -0700
Subject: [PATCH] ARM: qcom: add memory node to IPQ806x/AP148
Message-ID: <1439936804-15138-1-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On recent bootloaders, the bootloader patches the DT blob with memory
information. However, with old bootloader, this operation doesn't
happen, which leads the board to freeze in the early init code.

This patch adds the memory node to the AP148 dts explicitly to cover all
boot cases.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index 36e2b04..6886d09 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -4,6 +4,11 @@
 	model = "Qualcomm IPQ8064/AP148";
 	compatible = "qcom,ipq8064-ap148", "qcom,ipq8064";
 
+	memory at 0 {
+		reg = <0x42000000 0x1e000000>;
+		device_type = "memory";
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.4
