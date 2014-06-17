From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 17 Jun 2014 15:58:00 +0800
Subject: [PATCH 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <1402991881-27676-1-git-send-email-zhangfei.gao@linaro.org>
References: <1402991881-27676-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1402991881-27676-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiancheng Xue <xuejiancheng@huawei.com>

Add necessary binding documentation SATA PHY on Hisilicon hix5hd2 soc.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/phy/hix5hd2-sata-phy.txt   |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
new file mode 100644
index 0000000..ed15123
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
@@ -0,0 +1,26 @@
+Hisilicon hix5hd2 SATA PHY
+-----------------------
+
+Required properties:
+- compatible: should be "hisilicon,hix5hd2-sata-phy"
+- reg: offset and length of the PHY registers
+- #phy-cells: must be 0
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Optional Properties:
+- hisilicon,peri-syscon: phandle of syscon used to control peripheral.
+- hisilicon,power-reg: offset and bit number of the sata power supply register.
+  Only effective when hisilicon,peri-syscon is supplied.
+- hisilicon,reg-init: one of more sets of 4 cells.  The first cell
+  is the register offset address, the second cell is the start bit in register,
+  the third cell means the bit width, and the fourth cell is the value to set.
+
+Example:
+	sata_phy: phy at f9900000 {
+		compatible = "hisilicon,hix5hd2-sata-phy";
+		reg = <0xf9900000 0x10000>;
+		#phy-cells = <0>;
+		hisilicon,peri-syscon = <&peri_ctrl>;
+		hisilicon,power-reg = <0x8 10>;
+		hisilicon,reg-init = <0x148 0 32 0x345cb8>,<0x14c 0 32 0x20545>;
+	};
-- 
1.7.9.5
