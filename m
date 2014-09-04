From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Sep 2014 15:39:50 +0100
Subject: [PATCH 3/4] watchdog: st_wdt: Provide binding documentation for ST's
 LPC Watchdog driver
In-Reply-To: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409841592-18890-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/watchdog/st-lpc-wdt.txt    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt b/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
new file mode 100644
index 0000000..f0e57ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
@@ -0,0 +1,27 @@
+STMicroelectronics LPC Watchdog
+===============================
+
+Required properties
+
+- compatible 	: "st,<soc>-watchdog"
+- reg		: LPC registers base address + range
+- reg-names	: Register map "base" and "syscfg-en" are compulsory "type" is
+		  platform dependent and not required for the STiH407.
+- clock-names 	: Should be "lpc_wdt"
+- clocks	: Clock used by LPC device
+- timeout-sec	: Qatchdog timeout in seconds
+- st,syscfg	: Syscfg node used to configure cpu reset type and mask
+- st,warm_reset	: If present, reset type will be 'warm'. If not, it will be cold
+
+Example:
+	watchdog at fde05000 {
+		compatible	= "st,stih416-lpc-watchdog";
+		reg		= <0xfde05000 0x1000> <0x204 0x4>;
+		reg-names	= "base", "syscfg-en"
+		clock-names	= "lpc_wdt";
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		timeout-sec	= <600>;
+		st,syscfg	= <&syscfg_core>;
+		st,warm_reset;
+	};
+
-- 
1.9.1
