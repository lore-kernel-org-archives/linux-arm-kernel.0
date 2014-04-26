From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:08 +0400
Subject: [PATCH 3/8] ARM: dts: imx27-phytec-phycore-som: Disable PM pins for
 USB OTG
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB PWR and OC pins are used as GPIOs for different purposes,
so add "disable-over-current" property for OTG node to indicate this.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 93482e9..b81796c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -323,6 +323,7 @@
 	phy_type = "ulpi";
 	fsl,usbphy = <&usbphy0>;
 	vbus-supply = <&sw3_reg>;
+	disable-over-current;
 	status = "okay";
 };
 
-- 
1.8.3.2
