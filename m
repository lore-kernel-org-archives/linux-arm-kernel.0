From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:45 -0300
Subject: [PATCH 7/7] ARM: dts: imx25-pdk: Add USB Host1 support
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-7-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
The following driver patch is also needed in order to get USB functional on mx25:
http://www.spinics.net/lists/linux-usb/msg104080.html

 arch/arm/boot/dts/imx25-pdk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7a6d21f..0394313 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -107,3 +107,9 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbhost1 {
+	phy_type = "serial";
+	dr_mode = "host";
+	status = "okay";
+};
-- 
1.8.1.2
