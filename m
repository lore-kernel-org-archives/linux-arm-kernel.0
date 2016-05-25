From: carlo@caione.org (Carlo Caione)
Date: Wed, 25 May 2016 22:18:31 +0200
Subject: [PATCH v4 3/3] ARM64: dts: amlogic: gxbb: Enable secure monitor
In-Reply-To: <1464207511-11786-1-git-send-email-carlo@caione.org>
References: <1464207511-11786-1-git-send-email-carlo@caione.org>
Message-ID: <1464207511-11786-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the secure monitor node in the Amlogic Meson GXBB DTSI file to
enable it.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 76b3b6d..735a751 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
+#include <dt-bindings/firmware/meson-sm.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -98,6 +99,14 @@
 		method = "smc";
 	};
 
+	firmware {
+		compatible = "simple-bus";
+
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.7.4
