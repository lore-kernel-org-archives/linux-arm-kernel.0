From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 26 Oct 2018 15:51:20 +0800
Subject: [PATCH v2 4/4] dt-bindings/irqchip/mbigen: add example of MBIGEN
 generate SPIs
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1540540280-26612-5-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now MBIGEN can support to generate SPIs by writing
GICD_SETSPIR. Add dt example to help document.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../interrupt-controller/hisilicon,mbigen-v2.txt        | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
index a6813a0..298c033 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
@@ -10,7 +10,7 @@ Hisilicon designed mbigen to collect and generate interrupt.
 
 
 Non-pci devices can connect to mbigen and generate the
-interrupt by writing ITS register.
+interrupt by writing GICD or ITS register.
 
 The mbigen chip and devices connect to mbigen have the following properties:
 
@@ -64,6 +64,13 @@ Examples:
 				num-pins = <2>;
 				#interrupt-cells = <2>;
 			};
+
+			mbigen_spi_example:spi_example {
+				interrupt-controller;
+				msi-parent = <&gic>;
+				num-pins = <2>;
+				#interrupt-cells = <2>;
+			};
 	};
 
 Devices connect to mbigen required properties:
@@ -82,3 +89,11 @@ Examples:
 		interrupts =	<656 1>,
 				<657 1>;
 	};
+
+	spi_example: spi0 at 0 {
+		compatible = "spi,example";
+		reg = <0 0 0 0>;
+		interrupt-parent = <&mbigen_spi_example>;
+		interrupts = <13 4>,
+			     <14 4>;
+	};
-- 
1.8.3
