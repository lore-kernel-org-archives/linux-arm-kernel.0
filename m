From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 14:42:24 +0530
Subject: [PATCH v4 5/6] ARM: dts: imx6dl-icore: Add touchscreen node
In-Reply-To: <1505121145-9507-1-git-send-email-jteki@openedev.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
Message-ID: <1505121145-9507-5-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 DualLite/Solo module is
connected via i2c1, so add max11801: touchscreen at 48 on i2c1.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3,v2:
- none

 arch/arm/boot/dts/imx6dl-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index 360c32e..35211f3 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
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
2.7.4
