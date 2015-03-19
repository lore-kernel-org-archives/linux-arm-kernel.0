From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 18 Mar 2015 20:39:37 -0700
Subject: [patch 6/7] dt: dtb version: dtsi files
In-Reply-To: <550A42AC.8060104@gmail.com>
References: <550A42AC.8060104@gmail.com>
Message-ID: <550A44F9.9060504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sonymobile.com>

Create a .dtsi file to contain the /chosen/dtb-info node and populate the
properties in that node.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
---
 arch/arm/boot/dts/skeleton.dtsi              |    2 
 include/dt-bindings/version.dtsi             |   19 +++++

Index: b/include/dt-bindings/version.dtsi
===================================================================
--- /dev/null
+++ b/include/dt-bindings/version.dtsi
@@ -0,0 +1,19 @@
+
+#include <utsrelease.h>
+#include <compile.h>
+#include <compile_dtb.h>
+
+/ {
+	chosen {
+		dtb-info {
+			version = UTS_RELEASE, " ", DTB_VERSION;
+			version-linux =
+				UTS_RELEASE,
+				" (", LINUX_COMPILE_BY, "@", LINUX_COMPILE_HOST, ") ",
+				"(", LINUX_COMPILER, ") ",
+				UTS_VERSION;
+			dtb-path = ___DTB_DTB_PATH;
+			dts-path = ___DTB_DTS_PATH;
+		};
+	};
+};
Index: b/arch/arm/boot/dts/skeleton.dtsi
===================================================================
--- a/arch/arm/boot/dts/skeleton.dtsi
+++ b/arch/arm/boot/dts/skeleton.dtsi
@@ -11,3 +11,5 @@
 	aliases { };
 	memory { device_type = "memory"; reg = <0 0>; };
 };
+
+#include <dt-bindings/version.dtsi>
