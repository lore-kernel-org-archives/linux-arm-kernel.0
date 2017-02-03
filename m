From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri,  3 Feb 2017 13:11:52 +0100
Subject: [PATCH v2 7/8] ARM: dts: bcm283x: switch from &sdhci to &sdhost
In-Reply-To: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Message-ID: <1486123913-31705-8-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdcard access with the sdhost controller is faster.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 7d89af2..e6beecb 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -65,13 +65,13 @@
 &sdhci {
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio48>;
-	status = "okay";
 	bus-width = <4>;
 };
 
 &sdhost {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
 	bus-width = <4>;
 };
 
-- 
1.8.3.1
