From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 16:41:21 -0700
Subject: [PATCH] ARM: exynos: dts: cros5250: add cyapa trackpad
Message-ID: <1367019681-31775-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial patch, adding the i2c Cypress trackpad used on Snow.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Kukjin, if you don't mind I'll just add this to arm-soc?


-Olof

 arch/arm/boot/dts/cros5250-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index ebfa805..a3330a9 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -175,6 +175,14 @@
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
+
+		trackpad {
+			reg = <0x67>;
+			compatible = "cypress,cyapa";
+			interrupts = <2 0>;
+			interrupt-parent = <&gpx1>;
+			wakeup-source;
+		};
 	};
 
 	i2c at 12C80000 {
-- 
1.8.1.192.gc4361b8
