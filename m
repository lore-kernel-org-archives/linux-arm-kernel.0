From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 30 Aug 2018 14:59:39 +0800
Subject: [PATCH] ARM: dts: imx6sx-sdb: enable gpio buttons as wakeup source
Message-ID: <1535612379-8793-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i.MX6SX SDB board's below GPIO buttons
as wakeup sources:

SW4(FUNC1): KEY_VOLUMEUP
SW5(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index f8f3187..53b3408 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -40,12 +40,14 @@
 			label = "Volume Up";
 			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
 		};
 	};
 
-- 
2.7.4
