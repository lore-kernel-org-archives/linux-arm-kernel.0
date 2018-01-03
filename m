From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 11:32:37 -0800
Subject: [PATCH v3] ARM: dts: imx6: RDU2: disable internal watchdog
Message-ID: <20180103193237.15716-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

The system has an external watchdog in the environment processor
so the internal watchdog is of no use.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: cphealy at gmail.com
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v2]:

 - Collected Reviewed-by from Fabio

 - Moved wdog to be after audmux

Changes since [v1]:

 - Submission updated to have correct "From" field.

[v2] lkml.kernel.org/r/20180101212451.11516-1-andrew.smirnov at gmail.com
[v1] lkml.kernel.org/r/20171227035656.4941-2-andrew.smirnov at gmail.com


 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 881c3ee71016..199fda67f84f 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -859,6 +859,10 @@
 	};
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_accel: accelgrp {
 		fsl,pins = <
-- 
2.14.3
