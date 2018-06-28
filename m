From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 21:24:23 -0700
Subject: [PATCH 3/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight
 node
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Message-ID: <20180628042424.12664-4-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RAVE SP found on RDU2 implements backlight control compatible with the
rave-sp-backlight driver. Add a node to make it availible.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index e4630481d951..48da4b15da09 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -327,6 +327,10 @@
 			compatible = "zii,rave-sp-watchdog";
 		};
 
+		backlight {
+			compatible = "zii,rave-sp-backlight";
+		};
+
 		eeprom at a3 {
 			compatible = "zii,rave-sp-eeprom";
 			reg = <0xa3 0x4000>;
-- 
2.17.1
