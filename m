From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 11:01:57 +0100
Subject: [PATCH v3][ 8/9] ARM: dts: mbimxsd35 baseboard: Add USB support.
In-Reply-To: <1394618518-13803-1-git-send-email-denis@eukrea.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
Message-ID: <1394618518-13803-8-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- With the clock fix patches, the usb gadget also work.
  So I've set the otg port to otg instead of host.
- Before I forgott to set dr_mode to host in the usbhost port.
  That is now fixed.
---
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index 71197b9..f04ae91 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -150,3 +150,16 @@
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
