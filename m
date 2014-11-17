From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 17 Nov 2014 16:48:04 +0000
Subject: [PATCH v3 11/11] ARM: STi: DT: STiH416: Change miphy356 node name to
 phy@fe382000
In-Reply-To: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
References: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416242884-5261-12-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Arnds review comments, update the miphy365 to follow the
common convention of naming the phy node names as phy at addr.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/stih416-b2020.dts  | 2 +-
 arch/arm/boot/dts/stih416-b2020e.dts | 2 +-
 arch/arm/boot/dts/stih416.dtsi       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 5d1543b..200a818 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -20,7 +20,7 @@
 			non-removable;
 		};
 
-		miphy365x_phy: miphy365x at fe382000 {
+		miphy365x_phy: phy at fe382000 {
 			phy_port0: port at fe382000 {
 				st,sata-gen = <3>;
 			};
diff --git a/arch/arm/boot/dts/stih416-b2020e.dts b/arch/arm/boot/dts/stih416-b2020e.dts
index 956fab8..961799e 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -38,7 +38,7 @@
 			non-removable;
 		};
 
-		miphy365x_phy: miphy365x at fe382000 {
+		miphy365x_phy: phy at fe382000 {
 			phy_port0: port at fe382000 {
 				st,sata-gen = <3>;
 			};
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 2bdda52..fad9073 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -281,7 +281,7 @@
 			clocks		= <&clk_s_a1_ls 8>;
 		};
 
-		miphy365x_phy: miphy365x at fe382000 {
+		miphy365x_phy: phy at fe382000 {
 			compatible      = "st,miphy365x-phy";
 			st,syscfg  	= <&syscfg_rear>;
 			#address-cells	= <1>;
-- 
1.9.1
