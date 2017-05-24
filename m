From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 24 May 2017 14:02:42 +0900
Subject: [PATCH] ARM: dts: imx6: use #include "..." to include local DT
Message-ID: <1495602162-14672-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but we have some exceptional files
that use #include <...> for that.

Fix them to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
dtc_cpp_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index b2d346640fd7..6be8a1eea895 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6q.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6q.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2 Board";
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 882b3bd97e07..547a76677ab3 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6qp.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6qp.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2+ Board";
-- 
2.7.4
