From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 29 Aug 2018 09:45:38 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
Message-ID: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i.MX7D SDB board's below GPIO buttons
as wakeup sources:

S1(FUNC1): KEY_VOLUMEUP
S3(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index c9b3c60..f1bafda 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -27,12 +27,14 @@
 			label = "Volume Up";
 			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
 		};
 	};
 
-- 
2.7.4
