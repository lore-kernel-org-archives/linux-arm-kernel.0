From: chenyu56@huawei.com (Yu Chen)
Date: Tue, 24 Oct 2017 14:06:08 +0800
Subject: [RFC 1/3] USB: Add document for usb of Hikey960
In-Reply-To: <20171024060610.10712-1-chenyu56@huawei.com>
References: <20171024060610.10712-1-chenyu56@huawei.com>
Message-ID: <20171024060610.10712-2-chenyu56@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings for usb of Hikey960.

Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Ning Fan <fanning4@hisilicon.com>
Signed-off-by: Di Yang <yangdi10@hisilicon.com>
Signed-off-by: Rui Li <lirui39@hisilicon.com>

---
 .../devicetree/bindings/usb/hisilicon-usb.txt      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/hisilicon-usb.txt b/Documentation/devicetree/bindings/usb/hisilicon-usb.txt
new file mode 100644
index 000000000000..dc4c460885d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon-usb.txt
@@ -0,0 +1,38 @@
+* HISILICON USB HUB
+
+Required properties:
+- compatible: One of the specific types :"hisilicon,hi3660-dwc3",
+			"hisilicon,gpio_hubv1","hisilicon,gpio_hubv2"
+
+Optional properties of devices using ISP1301:
+- transceiver: phandle of isp1301 - this helps the ISP1301 driver to find the
+               ISP1301 instance associated with the respective USB driver
+
+Example:
+
+	hisi_usb at ff200000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "hisilicon,hi3660-dwc3";
+		reg = <0x0 0xff200000 0x0 0x1000
+			 0x0 0xff100000 0x0 0x100000>;
+		ranges;
+		bc_again_flag = <0>;
+
+		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
+			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
+		eye_diagram_param = <0x1c466e3>;
+		eye_diagram_host_param = <0x1c466e3>;
+		usb3_phy_cr_param = <0xb80>;
+		usb3_phy_host_cr_param = <0x980>;
+		usb3_phy_tx_vboost_lvl = <0x5>;
+
+		dwc3 at ff100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff100000 0x0 0x100000>;
+			interrupts = <0 159 4>, <0 161 4>;
+			dr_mode = "otg";
+			maximum-speed = "super-speed";
+		};
+	};
\ No newline at end of file
-- 
2.11.GIT
