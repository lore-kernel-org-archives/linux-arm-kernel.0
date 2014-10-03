From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri,  3 Oct 2014 23:35:47 +0800
Subject: [PATCH v4 1/3] i2c: hix5hd2: add devicetree documentation
In-Reply-To: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
References: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1412350549-2607-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yan <sledge.yanwei@huawei.com>

Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
new file mode 100644
index 0000000..660b7ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
@@ -0,0 +1,25 @@
+I2C for Hisilicon hix5hd2 chipset platform
+
+Required properties:
+- compatible: Must be "hisilicon,hix5hd2-i2c"
+- reg: physical base address of the controller and length of memory mapped
+     region.
+- interrupts: interrupt number to the cpu.
+- #address-cells = <1>;
+- #size-cells = <0>;
+- clocks: phandles to input clocks.
+
+Optional properties:
+- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000
+- Child nodes conforming to i2c bus binding
+
+Examples:
+I2C0 at f8b10000 {
+	compatible = "hisilicon,hix5hd2-i2c";
+	reg = <0xf8b10000 0x1000>;
+	interrupts = <0 38 4>;
+	clocks = <&clock HIX5HD2_I2C0_RST>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+}
-- 
1.7.9.5
