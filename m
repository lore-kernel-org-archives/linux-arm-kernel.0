From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue,  7 Oct 2014 09:04:11 +0800
Subject: [PATCH v5 1/3] i2c: hix5hd2: add devicetree documentation
In-Reply-To: <1412643853-11115-1-git-send-email-zhangfei.gao@linaro.org>
References: <1412643853-11115-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1412643853-11115-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yan <sledge.yanwei@huawei.com>

Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
new file mode 100644
index 0000000..f98b374
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
@@ -0,0 +1,24 @@
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
+}
-- 
1.7.9.5
