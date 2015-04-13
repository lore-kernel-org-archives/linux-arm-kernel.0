From: bintian.wang@huawei.com (Bintian Wang)
Date: Mon, 13 Apr 2015 17:17:36 +0800
Subject: [PATCH v2 2/6] arm64: hi6220: Document devicetree bindings for
 Hisilicon hi6220 SoC
In-Reply-To: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1428916660-25910-3-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by the
DT files of Hisilicon hi6220 SoC mobile platform.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 35b1bd4..66ad65d 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -13,6 +13,9 @@ HiP01 ca9x2 Board
 Required root node properties:
 	- compatible = "hisilicon,hip01-ca9x2";
 
+HiKey Board
+Required root node properties:
+	- compatible = "hisilicon,hi6220-hikey";
 
 Hisilicon system controller
 
@@ -29,6 +32,10 @@ Optional properties:
 - resume-offset : offset in sysctrl for notifying cpu0 when resume
 - reboot-offset : offset in sysctrl for system reboot
 
+For some SoCs(e.g. Hi6220), many clock registers are defined under this
+controller, so "#clock-cells" is a required property for these SoCs and
+it should be set to 1.
+
 Example:
 
 	/* for Hi3620 */
@@ -40,6 +47,72 @@ Example:
 		reboot-offset = <0x4>;
 	};
 
+
+Hisilicon Power Always ON domain controller
+
+Hisilicon designs this system controller to control the power always
+on domain for mobile platform.
+
+Required properties:
+- compatible : "hisilicon,aoctrl"
+- reg : Register address and size
+
+For some SoCs(e.g. Hi6220), many clock registers are defined under this
+controller, so "#clock-cells" is a required property for these SoCs and
+it should be set to 1.
+
+Example:
+	/*for Hi6220*/
+	ao_ctrl: ao_ctrl {
+		compatible = "hisilicon,aoctrl", "syscon";
+		reg = <0x0 0xf7800000 0x0 0x2000>;
+		#clock-cells = <1>;
+	};
+
+
+Hisilicon Media domain controller
+
+Hisilicon designs this system controller to control the multimedia
+domain(e.g. codec, G3D ...) for mobile platform.
+
+Required properties:
+- compatible : "hisilicon,mediactrl"
+- reg : Register address and size
+
+For some SoCs(e.g. Hi6220), many clock registers are defined under this
+controller, so "#clock-cells" is a required property for these SoCs and
+it should be set to 1.
+
+Example:
+	/*for Hi6220*/
+	media_ctrl: media_ctrl {
+		compatible = "hisilicon,mediactrl", "syscon";
+		reg = <0x0 0xf4410000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+
+Hisilicon Power Management domain controller
+
+Hisilicon designs this system controller to control the power management
+domain for mobile platform.
+
+Required properties:
+- compatible : "hisilicon,pmctrl"
+- reg : Register address and size
+
+For some SoCs (e.g. Hi6220), many clock registers are defined under this
+controller, so "#clock-cells" is a required property for these SoCs and
+it should be set to 1.
+
+Example:
+	/*for Hi6220*/
+	pm_ctrl: pm_ctrl {
+		compatible = "hisilicon,pmctrl", "syscon";
+		reg = <0x0 0xf7032000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 -----------------------------------------------------------------------
 Hisilicon HiP01 system controller
 
-- 
1.9.1
