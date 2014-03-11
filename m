From: denis@eukrea.com (Denis Carikli)
Date: Tue, 11 Mar 2014 11:55:01 +0100
Subject: [PATCH v2][ 5/8] ARM: dts: mbimxsd25 baseboard: Add USB support
In-Reply-To: <1394535304-10240-1-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
Message-ID: <1394535304-10240-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- With the clock fix patches, the usb gadget also work.
  So I've set the otg port to otg instead of host.
---
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 62fb3da..ad12da3 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -172,3 +172,16 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbhost1 {
+	phy_type = "serial";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg {
+	phy_type = "utmi";
+	dr_mode = "otg";
+	external-vbus-divider;
+	status = "okay";
+};
-- 
1.7.9.5
