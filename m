From: smoch@web.de (Soeren Moch)
Date: Sun,  7 Feb 2016 19:34:30 +0100
Subject: [PATCH 1/4] ARM: dts: imx6q-tbs2910: add SATA PHY configuration
Message-ID: <1454870073-6506-1-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure SATA PHY transmit level, boost, attenuation and equalizer
parameters for long wire connections. TBS2910 contains a standard SATA
connector, so devices are typically connected with (longer) SATA cables.
And explicitly configuring these parameters avoids complaints about
"not specified" values in boot messages.

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 5645d52..d8155d0 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -205,6 +205,10 @@
 };
 
 &sata {
+	fsl,transmit-level-mV = <1104>;
+	fsl,transmit-boost-mdB = <3330>;
+	fsl,transmit-atten-16ths = <16>;
+	fsl,receive-eq-mdB = <3000>;
 	status = "okay";
 };
 
-- 
1.9.1
