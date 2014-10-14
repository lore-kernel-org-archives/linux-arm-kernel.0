From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:13:00 +0200
Subject: [PATCH 7/8] ARM: ux500: Add spi and ssp devices to the VAPE PM domain
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi-pl022 driver handle these devices properly from a runtime PM
perspective. Therefore, let's add them into VAPE PM domain for ux500.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 41009c1..c51c11f 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -714,6 +714,7 @@
 			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		ssp at 80003000 {
@@ -727,6 +728,7 @@
 			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		spi at 8011a000 {
@@ -741,6 +743,7 @@
 			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		spi at 80112000 {
@@ -755,6 +758,7 @@
 			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		spi at 80111000 {
@@ -769,6 +773,7 @@
 			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		spi at 80129000 {
@@ -783,6 +788,7 @@
 			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		uart at 80120000 {
-- 
1.9.1
