From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  8 Jun 2013 18:39:39 +0400
Subject: [PATCH 4/5] ARM: dts: imx27-phytec-phycore-rdk: Add spidev node
In-Reply-To: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
References: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370702380-25408-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds spidev device for spi0.1 which is used on ZigBee
PCM970 connector.  This change will help to use this connector in
userspace.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index e7ed978..b2dbcdd 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -17,6 +17,12 @@
 &cspi1 {
 	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
+
+	zigbee: spidev at 1 {
+		compatible = "rohm,dh2228fv";
+		reg = <1>;
+		spi-max-frequency = <0>;
+	};
 };
 
 &sdhci2 {
-- 
1.8.1.5
