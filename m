From: jagan@openedev.com (Jagan Teki)
Date: Thu, 23 Mar 2017 00:35:18 +0530
Subject: [PATCH v8 3/3] ARM: dts: imx6q-icore: Add touchscreen node
In-Reply-To: <1490209518-20790-1-git-send-email-jagan@openedev.com>
References: <1490209518-20790-1-git-send-email-jagan@openedev.com>
Message-ID: <1490209518-20790-3-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 Quad module is
connected via i2c1, so add max11801: touchscreen at 48 on i2c1.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v8:
- Use IRQ_TYPE_EDGE_FALLING for interrupt trigger type. 
Changes for v7:
- add vendor prefix as maxim
Changes for v6:
- Replace the lable and name of the node
   ts: max11801 => max11801: touchscreen at 48
Changes for v5:
- Newly added patch

 arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 73f34d1..5613dd9 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&i2c1 {
+	max11801: touchscreen at 48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
-- 
1.9.1
