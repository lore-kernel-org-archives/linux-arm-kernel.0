From: denis@eukrea.com (Denis Carikli)
Date: Wed, 18 Jun 2014 14:56:56 +0200
Subject: [PATCH] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: unbreak esdhc.
Message-ID: <1403096216-21292-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit:
89d7e5c mmc: sdhci-esdhc-imx: add runtime pm support
has the effect of also disabling the hardware card detect
in runtime pm.

We switch to GPIO based detection to avoid this issue.

This patch is based on:
ARM: dts: imx51-babbage: Fix esdhc setup

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 75e66c9..1d77381 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -108,6 +108,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1 &pinctrl_esdhc1_cd>;
 	fsl,cd-controller;
+	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+
 	status = "okay";
 };
 
@@ -206,7 +208,7 @@
 
 		pinctrl_esdhc1_cd: esdhc1_cd {
 			fsl,pins = <
-				MX51_PAD_GPIO1_0__SD1_CD 0x20d5
+				MX51_PAD_GPIO1_0__GPIO1_0 0xd5
 			>;
 		};
 
-- 
1.7.9.5
