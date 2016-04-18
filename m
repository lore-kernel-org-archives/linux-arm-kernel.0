From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 18 Apr 2016 17:19:45 -0400
Subject: [PATCH 3/3] ARM: dts: imx: b450/b650v3: Move ldb_di clk assignment
In-Reply-To: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
References: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1461014385-26027-3-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the LDB_DIx clocks could be specified in the ldb node. With
the ERR009219 errata fix applied, the ldb_di clocks now needs to be
specified in the clks node to ensure the clocks are setup early in the
boot process.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-b450v3.dts | 5 ++++-
 arch/arm/boot/dts/imx6q-b650v3.dts | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index 3101be5..f0a2be5 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -65,11 +65,14 @@
 	};
 };
 
-&ldb {
+&clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
 			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
 				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
+&ldb {
 	status = "okay";
 
 	lvds0: lvds-channel at 0 {
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 823f55c..33cb71a 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -65,11 +65,14 @@
 	};
 };
 
-&ldb {
+&clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
 			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
 				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
+&ldb {
 	status = "okay";
 
 	lvds0: lvds-channel at 0 {
-- 
2.8.1
