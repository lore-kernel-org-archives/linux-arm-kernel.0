From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  7 Dec 2016 08:56:53 +0100
Subject: [PATCH V2 3/5] ARM: BCM5301X: Set GPIO enabling USB power on Netgear
 R7000
In-Reply-To: <20161207075655.7396-1-zajec5@gmail.com>
References: <20161207075655.7396-1-zajec5@gmail.com>
Message-ID: <20161207075655.7396-3-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

There is one GPIO controlling power for both USB ports.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
V2: Avoid double Signed-off-by due to different e-mail address
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
