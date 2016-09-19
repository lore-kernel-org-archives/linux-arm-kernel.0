From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 19 Sep 2016 08:59:58 +0000
Subject: [PATCH V6 4/6] ARM64: bcm2835: dts: add thermal node to device-tree
 of bcm2837
In-Reply-To: <1474275600-19378-1-git-send-email-kernel@martin.sperl.org>
References: <1474275600-19378-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1474275600-19378-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the node for the thermal sensor of the bcm2837-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

Note: untested as I have no 64 bit test system.

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index f2a31d0..2b0cfc7 100644
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
