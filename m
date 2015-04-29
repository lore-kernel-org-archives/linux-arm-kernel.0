From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Apr 2015 23:59:27 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q-cubox-i: Disable the internal RTC
In-Reply-To: <1430276367-18068-1-git-send-email-festevam@gmail.com>
References: <1430276367-18068-1-git-send-email-festevam@gmail.com>
Message-ID: <1430276367-18068-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The internal SNVS RTC on imx6q-cubox-i is not battery backed and there
is a PCF8523 that is battery backed on CuBox-i2eX and CuBox-i4Pro models.

Disable the internal RTC in favour of the battery backed one, so that
we can have a valid clock setting right after boot.

Reported-by: Rick Thomas <rbthomas@cube.rcthomas.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index 670bd8c..cff041a 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -56,3 +56,7 @@
 	fsl,transmit-atten-16ths = <9>;
 	fsl,no-spread-spectrum;
 };
+
+&snvs_rtc {
+	status = "disabled";
+};
-- 
1.9.1
