From: denis@eukrea.com (Denis Carikli)
Date: Tue, 17 Jun 2014 12:46:37 +0200
Subject: [PATCH 1/3] ARM: dts: mbimxsd25: cmo-qvga: Fix lcd regulator
Message-ID: <1403001999-12316-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed-regulator's enable-active-high property
is needed to indicate that the GPIO regulator is
active high.

Before that the regulator state was inverted.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 9797280..68d0834 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -52,6 +52,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
 		};
 	};
 };
-- 
1.7.9.5
