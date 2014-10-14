From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:13:01 +0200
Subject: [PATCH 8/8] ARM: ux500: Add i2c devices to the VAPE PM domain
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c-nomadik driver handle these devices properly from a runtime PM
perspective. Therefore, let's add them into VAPE PM domain for ux500.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index c51c11f..bfd3f1c 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -641,6 +641,7 @@
 			clock-frequency = <400000>;
 			clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
 			clock-names = "i2cclk", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		i2c at 80122000 {
@@ -656,6 +657,7 @@
 
 			clocks = <&prcc_kclk 1 2>, <&prcc_pclk 1 2>;
 			clock-names = "i2cclk", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		i2c at 80128000 {
@@ -671,6 +673,7 @@
 
 			clocks = <&prcc_kclk 1 6>, <&prcc_pclk 1 6>;
 			clock-names = "i2cclk", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		i2c at 80110000 {
@@ -686,6 +689,7 @@
 
 			clocks = <&prcc_kclk 2 0>, <&prcc_pclk 2 0>;
 			clock-names = "i2cclk", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		i2c at 8012a000 {
@@ -701,6 +705,7 @@
 
 			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 10>;
 			clock-names = "i2cclk", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		ssp at 80002000 {
-- 
1.9.1
