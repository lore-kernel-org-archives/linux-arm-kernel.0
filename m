From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:10 +0100
Subject: [PATCH v4 6/7] arm: dts: bcm283x: switch from &sdhci to &sdhost
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-11-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdcard access with the sdhost controller is faster.

Read access (dd with 64k blocks on rpi2):
   CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
   CONFIG_MMC_BCM2835:     19-20 MB/s

Differences on write access are pretty much in the noise.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 8b95832..e36c392 100644
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
