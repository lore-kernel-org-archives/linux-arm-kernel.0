From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:37 +0200
Subject: [PATCH 24/24] ARM: ux500: Add sdi[n] devices to VAPE power domain
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-25-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ux500 uses the mmci host driver for these devices and since that
driver are well behaving from a runtime PM perspective, we can now add
these device to the VAPE power domain.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 29a7013..630690b 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/dbx500-prcmu.h>
+#include <dt-bindings/arm/ux500_pm_domains.h>
 #include "skeleton.dtsi"
 
 / {
@@ -840,6 +841,7 @@
 
 			clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -855,6 +857,7 @@
 
 			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -870,6 +873,7 @@
 
 			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -881,6 +885,7 @@
 
 			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -896,6 +901,7 @@
 
 			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
@@ -907,6 +913,7 @@
 
 			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
 			clock-names = "sdi", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			status = "disabled";
 		};
-- 
1.7.9.5
