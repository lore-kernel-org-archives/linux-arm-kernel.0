From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  5 Jul 2013 15:45:09 +0200
Subject: [PATCH] ARM: dts: imx27 phyCARD-S remove wrong I2C RTC
In-Reply-To: <1372782469.486055292@f129.mail.ru>
References: <1372782469.486055292@f129.mail.ru>
Message-ID: <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixup of commit 7874d595b78e431f0f661d2fe47625649308a52e
"ARM: dts: Add device tree support for phycard pca100".

Remove wrong I2C RTC node.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Thanks, Alexander, you are right. I2C2 has no RTC.

Regards,

Markus

 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index ec52b6d..01ee807 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -55,11 +55,6 @@
 		reg = <0x4a>;
 	};
 
-	rtc at 51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-
 	at24 at 52 {
 		compatible = "at,24c32";
 		pagesize = <32>;
-- 
1.8.2.1
