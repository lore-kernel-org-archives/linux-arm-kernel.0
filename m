From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:19 +0100
Subject: [PATCH 5/9] ARM: dts: mbimxsd25 baseboard: Add USB host support
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394211863-7569-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 62fb3da..58c606f 100644
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
+	dr_mode = "host";
+	external-vbus-divider;
+	status = "okay";
+};
-- 
1.7.9.5
