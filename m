From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:21 +0100
Subject: [PATCH 7/9] ARM: dts: mbimxsd35 baseboard: Add USB host support.
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394211863-7569-7-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index 71197b9..d27f02e 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -150,3 +150,15 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbhost1 {
+	phy_type = "serial";
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
