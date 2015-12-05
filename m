From: yankejian@huawei.com (yankejian)
Date: Sat, 5 Dec 2015 15:56:58 +0800
Subject: [PATCH RESEND net-next 3/3] arm64: hip05-d02: Document devicetree
 bindings for Hisilicon D02 Board
In-Reply-To: <1449302218-54374-1-git-send-email-yankejian@huawei.com>
References: <1449302218-54374-1-git-send-email-yankejian@huawei.com>
Message-ID: <1449302218-54374-4-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by the
DT files of Hisilicon Hip05-D02 development board.

Signed-off-by: yankejian <yankejian@huawei.com>
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 6ac7c00..5318d78 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -187,6 +187,22 @@ Example:
 		reg = <0xb0000000 0x10000>;
 	};
 
+Hisilicon HiP05 PERISUB system controller
+
+Required properties:
+- compatible : "hisilicon,peri-c-subctrl", "syscon";
+- reg : Register address and size
+
+The HiP05 PERISUB system controller is shared by peripheral controllers in
+HiP05 Soc to implement some basic configurations. the peripheral
+ controllers include mdio, ddr, iic, uart, timer and so on.
+
+Example:
+	/* for HiP05 PCIe-SAS system */
+	pcie_sas: system_controller at 0xb0000000 {
+		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
+		reg = <0xb0000000 0x10000>;
+	};
 -----------------------------------------------------------------------
 Hisilicon CPU controller
 
-- 
1.9.1
