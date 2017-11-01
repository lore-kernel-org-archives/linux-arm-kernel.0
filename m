From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed,  1 Nov 2017 09:03:57 +0100
Subject: [PATCH 1/1] ARM: dts: sunxi: sun8i-h3-nanopi-m1-plus: Add missing
 regulator
In-Reply-To: <20171101080357.4241-1-clabbe.montjoie@gmail.com>
References: <20171101080357.4241-1-clabbe.montjoie@gmail.com>
Message-ID: <20171101080357.4241-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the missing regulator for sun8i-h3-nanopi-m1-plus.

Fixes: ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index cfb96da3cfef..0a8b79cf5954 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -51,6 +51,16 @@
 		ethernet1 = &sdio_wifi;
 	};
 
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
-- 
2.13.6
