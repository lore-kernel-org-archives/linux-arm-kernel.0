From: denis@eukrea.com (Denis Carikli)
Date: Wed, 13 Nov 2013 10:23:22 +0100
Subject: [PATCHv4][ 6/7] ARM: dts: mbimx51sd: Add CMO-QVGA backlight support.
In-Reply-To: <1384334603-14208-1-git-send-email-denis@eukrea.com>
References: <1384334603-14208-1-git-send-email-denis@eukrea.com>
Message-ID: <1384334603-14208-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v3:
- Splitted out from the patch that added support for the cpuimx51/mbimxsd51 boards.
- This patch now only adds backlight support.
- Added some interested people in the Cc list, and removed some people that
  might be annoyed by the receiving of that patch which is unrelated to their
  subsystem.
---
 .../imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts  |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
index 4c781e7..73b00b7 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
@@ -22,6 +22,14 @@
 	model = "Eukrea MBIMXSD51 with the CMO-QVGA Display";
 	compatible = "eukrea,mbimxsd51-baseboard-cmo-qvga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
 
+	backlight {
+		compatible = "gpio-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_1>;
+		gpios = <&gpio3 4 0>;
+		default-brightness-level = <1>;
+	};
+
 	reg_lcd_3v3: lcd-en {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
1.7.9.5
