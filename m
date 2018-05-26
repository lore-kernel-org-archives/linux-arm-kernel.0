From: akurz@blala.de (Alexander Kurz)
Date: Sat, 26 May 2018 18:30:53 +0000
Subject: [PATCH 3/3] ARM: dts: imx6dl-riotboard: fix OTG regulator polarity
In-Reply-To: <20180526183053.14029-1-akurz@blala.de>
References: <20180526183053.14029-1-akurz@blala.de>
Message-ID: <20180526183053.14029-4-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB OTG power is switched on when the GPIO is pulled low.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index a52e05934e3a..ef3b270c15e5 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -70,8 +70,7 @@
 		regulator-name = "usb_otg_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 0>;
-		enable-active-high;
+		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.11.0
