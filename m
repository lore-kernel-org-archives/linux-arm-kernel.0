From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 14 Sep 2015 19:06:36 +0800
Subject: [PATCH 1/3] dt-bindings: Add document of Rockchip mailbox
In-Reply-To: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1442228798-15191-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the necessary binding documentation for mailbox
found on RK3368 SoC.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 .../bindings/mailbox/rockchip-mailbox.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt b/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
new file mode 100644
index 0000000..b9b4768
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
@@ -0,0 +1,33 @@
+Rockchip mailbox
+
+The Rockchip mailbox is used by the Rockchip CPU cores to communicate
+requests to MCU processor.
+
+Refer to ./mailbox.txt for generic information about mailbox device-tree
+bindings.
+
+Required properties:
+
+ - compatible: should be one of the following.
+   - "rockchip,rk3368-mbox" for rk3368
+ - reg: physical base address of the controller and length of memory mapped
+	region.
+	physical base address of the share buffer and length of memory mapped
+	region.
+ - interrupts: The interrupt number to the cpu. The interrupt specifier format
+	depends on the interrupt controller.
+
+Example:
+--------
+
+/* RK3368 */
+mbox: mbox at ff6b0000 {
+	compatible = "rockchip,rk3368-mailbox";
+	reg = <0x0 0xff6b0000 0x0 0x1000>,
+	      <0x0 0xff8cf000 0x0 0x1000>; /* the end 4k of sram */
+	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+	#mbox-cells = <1>;
+};
-- 
1.9.1
