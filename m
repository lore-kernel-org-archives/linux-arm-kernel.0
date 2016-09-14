From: jaret.cantu@timesys.com (Jaret Cantu)
Date: Wed, 14 Sep 2016 17:14:49 -0400
Subject: [PATCH] ARM: dts: imx: b650v3: Calibrate USB PHY to pass eye diagram
 test
Message-ID: <1473887689-10792-1-git-send-email-jaret.cantu@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calibrate the USB PHY TX settings to pass the eye diagram signal
integrity test.  The settings are taken from the i.MX6 reference
manual's recommended configuration for USB certification (66.2.6).

Signed-off-by: Jaret Cantu <jaret.cantu@timesys.com>
---
 arch/arm/boot/dts/imx6q-b650v3.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 33cb71a..c266bd2 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -89,3 +89,9 @@
 		};
 	};
 };
+
+&usbphy1 {
+	fsl,tx-cal-45-dn-ohms = <55>;
+	fsl,tx-cal-45-dp-ohms = <55>;
+	fsl,tx-d-cal = <100>;
+};
-- 
1.7.10.4
