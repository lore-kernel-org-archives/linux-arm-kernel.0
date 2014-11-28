From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 28 Nov 2014 20:20:09 +0530
Subject: [PATCH RFT 2/2] arm: dts: disable CCI on exynos420 based arndale-octa
In-Reply-To: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arndale-octa board was giving "imprecise external aborts" during
boot-up with MCPM enabled. CCI enablement of the boot cluster was found
to be the cause of these aborts (possibly because the secure f/w was not
allowing it). Hence, disable CCI for the arndale-octa board.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |    4 ++++
 arch/arm/boot/dts/exynos5420.dtsi             |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index aa7a7d7..db2c1c4 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -372,3 +372,7 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
+
+&cci {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 517e50f..0a82ae7 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -120,7 +120,7 @@
 		};
 	};
 
-	cci at 10d20000 {
+	cci: cci at 10d20000 {
 		compatible = "arm,cci-400";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
