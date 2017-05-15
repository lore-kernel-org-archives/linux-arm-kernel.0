From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 15 May 2017 20:14:45 +0900
Subject: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the same
 directory
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but we have 3 exceptional files
that use #include <...> for that.

They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
path from dtc_cpp_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index b2d3466..6be8a1e 100644
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
index 882b3bd..547a766 100644
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
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 33a8eb2..06e2331 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -1,4 +1,4 @@
-#include <versatile-ab.dts>
+#include "versatile-ab.dts"
 
 / {
 	model = "ARM Versatile PB";
-- 
2.7.4
