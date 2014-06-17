From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:33 +0200
Subject: [PATCH 5/7] ARM: dts: imx2*, remove ssi fsl,mode for sgtl5000 cards
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DAI mode is and should be configured by the sound card driver as
codec and ssi have to be in the right modes to communicate with each
other. It is possible to operate the ssi unit or the codec in master mode,
sometimes even on the same board in different configurations.

With the latest changes in the fsl-ssi driver, the 'fsl,mode' property
is only handled as a fallback property. If the sound card sets the DAI
mode correctly, this fallback configuration is dropped.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25-pdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index c608942b8a3b..8f9a424a80d6 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -233,7 +233,6 @@
 
 &ssi1 {
 	codec-handle = <&codec>;
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
2.0.0
