From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:40 +0200
Subject: [PATCH 31/32] enable wireless
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-32-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

Signed-off-by: Eric Anholt <eric@anholt.net>

Conflicts:
	arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 202e8c3..8d24a39 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -55,3 +55,18 @@
 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
 };
+
+/* SDHOST is used to drive the SD card */
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
+};
+
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	status = "okay";
+	non-removable;
+};
-- 
1.8.3.1
