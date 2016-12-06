From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue,  6 Dec 2016 18:17:12 +0100
Subject: [PATCH 3/5] ARM: BCM5301X: Set GPIO enabling USB power on Netgear
 R7000
In-Reply-To: <20161206171714.22738-1-zajec5@gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
Message-ID: <20161206171714.22738-3-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is one GPIO controlling power for both USB ports.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index 0225d82..7ab1176 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -100,3 +100,11 @@
 		};
 	};
 };
+
+&usb2 {
+	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+};
-- 
2.10.1
