From: denis@eukrea.com (Denis Carikli)
Date: Tue,  5 Nov 2013 15:39:12 +0100
Subject: [PATCHv11][ 5/7] ARM: dts: imx25.dtsi: Permit to use the iomuxc in
 the dts.
In-Reply-To: <1383662354-22417-1-git-send-email-denis@eukrea.com>
References: <1383662354-22417-1-git-send-email-denis@eukrea.com>
Message-ID: <1383662354-22417-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An iomuxc label was added, and imx25-pingrp.h was included.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- New patch made from the remaining parts of the "ARM: dts: imx25.dtsi: Add
  some pinmux pins." patch in the old serie.
---
 arch/arm/boot/dts/imx25.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 1c19ad3..1a86eab 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -11,6 +11,7 @@
 
 #include "skeleton.dtsi"
 #include "imx25-pinfunc.h"
+#include "imx25-pingrp.h"
 
 / {
 	aliases {
@@ -174,7 +175,7 @@
 				status = "disabled";
 			};
 
-			iomuxc at 43fac000{
+			iomuxc: iomuxc at 43fac000 {
 				compatible = "fsl,imx25-iomuxc";
 				reg = <0x43fac000 0x4000>;
 			};
-- 
1.7.9.5
