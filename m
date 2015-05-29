From: bintian.wang@huawei.com (Bintian Wang)
Date: Fri, 29 May 2015 10:08:33 +0800
Subject: [PATCH v8 1/7] arm64: hi6220: Document devicetree bindings for
 Hisilicon hi6220 SoC
In-Reply-To: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
References: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1432865319-20413-2-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by the
DT files of Hisilicon hi6220 SoC mobile platform.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 35b1bd4..f67d0f3 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -1,5 +1,8 @@
 Hisilicon Platforms Device Tree Bindings
 ----------------------------------------------------
+Hi6220 SoC
+Required root node properties:
+	- compatible = "hisilicon,hi6220";
 
 Hi4511 Board
 Required root node properties:
@@ -13,6 +16,9 @@ HiP01 ca9x2 Board
 Required root node properties:
 	- compatible = "hisilicon,hip01-ca9x2";
 
+HiKey Board
+Required root node properties:
+	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
 
 Hisilicon system controller
 
@@ -41,6 +47,87 @@ Example:
 	};
 
 -----------------------------------------------------------------------
+Hisilicon Hi6220 system controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-sysctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this controller as one of the system controllers,
+its main functions are the same as Hisilicon system controller, but
+the register offset of some core modules are different.
+
+Example:
+	/*for Hi6220*/
+	sys_ctrl: sys_ctrl {
+		compatible = "hisilicon,hi6220-sysctrl", "syscon";
+		reg = <0x0 0xf7030000 0x0 0x2000>;
+		#clock-cells = <1>;
+	};
+
+
+Hisilicon Hi6220 Power Always ON domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-aoctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the power always
+on domain for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	ao_ctrl: ao_ctrl {
+		compatible = "hisilicon,hi6220-aoctrl", "syscon";
+		reg = <0x0 0xf7800000 0x0 0x2000>;
+		#clock-cells = <1>;
+	};
+
+
+Hisilicon Hi6220 Media domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-mediactrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the multimedia
+domain(e.g. codec, G3D ...) for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	media_ctrl: media_ctrl {
+		compatible = "hisilicon,hi6220-mediactrl", "syscon";
+		reg = <0x0 0xf4410000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+
+Hisilicon Hi6220 Power Management domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-pmctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, some clock registers are define
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the power management
+domain for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	pm_ctrl: pm_ctrl {
+		compatible = "hisilicon,hi6220-pmctrl", "syscon";
+		reg = <0x0 0xf7032000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+-----------------------------------------------------------------------
 Hisilicon HiP01 system controller
 
 Required properties:
-- 
1.9.1
