From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri, 15 Dec 2017 12:00:02 +0100
Subject: [PATCH v3 2/5] arm64: dts: rockchip: add the aclk_usb3 clocks for
 USB3.
In-Reply-To: <20171215110005.7564-1-enric.balletbo@collabora.com>
References: <20171215110005.7564-1-enric.balletbo@collabora.com>
Message-ID: <20171215110005.7564-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aclk_usb3 must be enabled to support USB3 for rk3399.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - Split the original patch in different commits
Changes since v2:
 - None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 17e5e1a..f32e9c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -397,9 +397,11 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
-			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
+			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "grf_clk";
 		status = "disabled";
 
 		usbdrd_dwc3_0: dwc3 {
@@ -425,9 +427,11 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
-			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
+			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "grf_clk";
 		status = "disabled";
 
 		usbdrd_dwc3_1: dwc3 {
-- 
2.9.3
