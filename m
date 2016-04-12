From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Tue, 12 Apr 2016 12:01:24 -0400
Subject: [PATCH v2] ARM: dts: imx6q-ba16: Remove unused vqmmc-supply
Message-ID: <1460476884-20612-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vqmmc supply is not connected to bio supply on the BA16 module.
Hence remove vqmmc-supply property in usdhc3 node.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
Changes in v2:
Use "ARM" instead of "arm" for patch subject
More descriptive commit message

 arch/arm/boot/dts/imx6q-ba16.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index fcc7b50..7c80a1e 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -392,7 +392,6 @@
 	pinctrl-0 = <&pinctrl_usdhc3 &pinctrl_usdhc3_reset>;
 	bus-width = <8>;
 	vmmc-supply = <&vdd_bperi>;
-	vqmmc-supply = <&vdd_bio>;
 	non-removable;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.8.1
