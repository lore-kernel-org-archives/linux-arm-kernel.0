From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 12 Jul 2018 10:02:36 -0300
Subject: [PATCH 1/3] ARM: dts: imx53-ppd: Enable secure-reg-access
Message-ID: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Add 'secure-reg-access' property to enable PMU and hardware counters
so that they can be properly used with the 'perf' tool.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[fabio: kept the change only in imx53-ppd context]
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 444ec84..cdb90be 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -594,6 +594,10 @@
 	};
 };
 
+&pmu {
+	secure-reg-access;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.7.4
