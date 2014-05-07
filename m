From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  7 May 2014 15:31:29 +0200
Subject: [PATCH 6/6] ARM: dts: Karo TX25: use hardware ecc
In-Reply-To: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
References: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1399469489-22788-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use hardware ecc on i.MX. While at it, add the optional
nand-bus-width property.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index ea7dddc..182704e 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -102,5 +102,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nfc>;
 	nand-on-flash-bbt;
+	nand-ecc-mode = "hw";
+	nand-bus-width = <8>;
 	status = "okay";
 };
-- 
2.0.0.rc0
