From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 18:30:23 +0200
Subject: [PATCH v3 3/4] ARM64: dts: amlogic: gxbb: Enable secure monitor
In-Reply-To: <1464021024-29380-1-git-send-email-carlo@caione.org>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
Message-ID: <1464021024-29380-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the secure monitor node in the Amlogic Meson GXBB DTSI file to
enable it.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 76b3b6d..aeff919 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
+#include <dt-bindings/firmware/meson-gxbb-sm.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -98,6 +99,16 @@
 		method = "smc";
 	};
 
+	firmware {
+		compatible = "simple-bus";
+
+		sm: secure-monitor {
+			compatible = "amlogic,meson-sm";
+			amlogic,sm-cmd-input-base = <SM_GET_SHARE_MEM_INPUT_BASE>;
+			amlogic,sm-cmd-output-base = <SM_GET_SHARE_MEM_OUTPUT_BASE>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.7.4
