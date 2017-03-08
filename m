From: jagan@openedev.com (Jagan Teki)
Date: Wed,  8 Mar 2017 12:47:55 +0530
Subject: [PATCH v4 5/7] arm: dts: imx6q-icore: Add touchscreen node
In-Reply-To: <1488957477-5621-1-git-send-email-jagan@openedev.com>
References: <1488957477-5621-1-git-send-email-jagan@openedev.com>
Message-ID: <1488957477-5621-5-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 Quad module is
connected via i2c1, so add tc: max11801 at 48 on i2c1.

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Newly added patch.

 arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 73f34d1..8c1a572 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&i2c1 {
+	ts: max11801 at 48 {
+		compatible = "max11801";
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
