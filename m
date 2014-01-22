From: denis@eukrea.com (Denis Carikli)
Date: Wed, 22 Jan 2014 14:48:31 +0100
Subject: [PATCHv6 7/7] ARM: dts: mbimx51sd: Add CMO-QVGA backlight support.
In-Reply-To: <1390398511-8041-1-git-send-email-denis@eukrea.com>
References: <1390398511-8041-1-git-send-email-denis@eukrea.com>
Message-ID: <1390398511-8041-7-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- Reordered the Cc list.

ChangeLog v3->v5:
- Updated to the new GPIO defines.

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
index f37d65b..f8f5abe 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
@@ -17,6 +17,14 @@
 	model = "Eukrea MBIMXSD51 with the CMO-QVGA Display";
 	compatible = "eukrea,mbimxsd51-baseboard-cmo-qvga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
 
+	backlight {
+		compatible = "gpio-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_1>;
+		gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+		default-brightness-level = <1>;
+	};
+
 	reg_lcd_3v3: lcd-en {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
1.7.9.5
