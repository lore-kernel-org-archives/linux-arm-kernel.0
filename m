From: carlo@caione.org (Carlo Caione)
Date: Wed, 18 May 2016 16:56:21 +0200
Subject: [PATCH v2 3/4] ARM64: dts: amlogic: gxbb: Enable secure monitor
In-Reply-To: <1463583382-15614-1-git-send-email-carlo@caione.org>
References: <1463583382-15614-1-git-send-email-carlo@caione.org>
Message-ID: <1463583382-15614-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the secure monitor node in the Amlogic Meson GXBB DTSI file to
enable it.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 76b3b6d..003e298 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
+#include <dt-bindings/soc/meson-gxbb-sm.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -98,6 +99,12 @@
 		method = "smc";
 	};
 
+	sm {
+		compatible = "amlogic,meson-sm";
+		amlogic,sm_cmd_input_base = <SM_GET_SHARE_MEM_INPUT_BASE>;
+		amlogic,sm_cmd_output_base = <SM_GET_SHARE_MEM_OUTPUT_BASE>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.7.4
