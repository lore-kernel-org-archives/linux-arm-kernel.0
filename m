From: stefan@agner.ch (Stefan Agner)
Date: Wed, 29 Mar 2017 16:21:11 -0700
Subject: [PATCH 3/5] ARM: dts: imx7-colibri: allow to disable Ethernet rail
In-Reply-To: <20170329232113.19078-1-stefan@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
Message-ID: <20170329232113.19078-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator-always-on property on the Ethernet rail prevents Linux
from disabling the rail when Ethernet is shut down (suspend or simply
link down). With this change the regulator framework will disable the
rail when the Ethernet PHY is not used, saving power especially on
carrier board not using Ethernet.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 47eab920666f..cbcab937b905 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -181,7 +181,7 @@
 			reg_LDO1: LDO1 { /* PWR_EN_+V3.3_ETH */
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
+				regulator-boot-on;
 			};
 
 			reg_LDO2: LDO2 { /* +V1.8_SD */
-- 
2.12.1
