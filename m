From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 12:36:29 +0100
Subject: [PATCH 4/4] ARM: dts: bcm283x: switch from &sdhci to &sdhost
In-Reply-To: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
Message-ID: <1485516989-1072-5-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flips the switch from (iproc-driven) sdhci controller to the custom
sdhost controller.

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
