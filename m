From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  1 Jan 2018 13:24:51 -0800
Subject: [PATCH v2] ARM: dts: imx6: RDU2: disable internal watchdog
Message-ID: <20180101212451.11516-1-andrew.smirnov@gmail.com>
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
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

 - Submission updated to have correct "From" field.

[v1] lkml.kernel.org/r/20171227035656.4941-2-andrew.smirnov at gmail.com


 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 6bef9a98678e..818bfc8692a5 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -838,6 +838,10 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
 &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
