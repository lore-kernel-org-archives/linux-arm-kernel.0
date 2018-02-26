From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 26 Feb 2018 06:49:42 -0800
Subject: [PATCH 2/2] ARM: dts: imx51-zii-rdu1: Add node for RAVE SP device
In-Reply-To: <20180226144943.9835-1-andrew.smirnov@gmail.com>
References: <20180226144943.9835-1-andrew.smirnov@gmail.com>
Message-ID: <20180226144943.9835-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With MFD and watchdog drivers for RAVE SP device support added by
538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
corresponding DT node for RDU.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 5306b78de0ca..43cd06230751 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -568,6 +568,17 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		status = "okay";
+		current-speed = <38400>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+			status = "okay";
+		};
+	};
 };
 
 &usbh1 {
-- 
2.14.3
