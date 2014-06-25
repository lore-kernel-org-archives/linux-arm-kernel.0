From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 17:28:52 -0300
Subject: [PATCH 1/2] ARM: dts: imx25-pdk: Add USB OTG support
Message-ID: <1403728133-12487-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Tested by loading the g_ether module and doing a ping between mx25pdk and the
host PC via USB.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 8f9a424..9c21b15 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -248,3 +248,10 @@
 	dr_mode = "host";
 	status = "okay";
 };
+
+&usbotg {
+	phy_type = "utmi";
+	dr_mode = "otg";
+	external-vbus-divider;
+	status = "okay";
+};
-- 
1.8.3.2
