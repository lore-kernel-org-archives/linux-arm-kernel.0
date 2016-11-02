From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed,  2 Nov 2016 10:18:24 +0000
Subject: [PATCH V8 4/6] ARM64: bcm2835: dts: add thermal node to device-tree
 of bcm2837
In-Reply-To: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1478081906-12009-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the node for the thermal sensor of the bcm2837-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index 8216bbb..0fc10fd 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -74,3 +74,9 @@
 	interrupt-parent = <&local_intc>;
 	interrupts = <8>;
 };
+
+/* enable thermal sensor with the correct compatible property set */
+&thermal {
+	compatible = "brcm,bcm2837-thermal";
+	status = "okay";
+};
-- 
2.1.4
