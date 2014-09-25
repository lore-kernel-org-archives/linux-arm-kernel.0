From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 25 Sep 2014 12:48:52 -0500
Subject: [PATCH v3 2/3] watchdog: qcom: document device tree bindings
In-Reply-To: <cover.1411667144.git.joshc@codeaurora.org>
References: <cover.1411667144.git.joshc@codeaurora.org>
Message-ID: <f49033de078aff9112fb8fa6fa4331e16998edf2.1411667144.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Qualcomm Krait Processor Sub-system (KPSS) contains one or more
instances of the WDT.  Provide documentation on how to describe these in
the device tree.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 .../devicetree/bindings/watchdog/qcom-wdt.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
new file mode 100644
index 0000000..c75566e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -0,0 +1,22 @@
+Qualcomm Krait Processor Sub-system (KPSS) Watchdog
+---------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,kpss-wdt-msm8960"
+			"qcom,kpss-wdt-apq8064"
+			"qcom,kpss-wdt-ipq8064"
+
+- reg : shall contain base register location and length
+- clocks : shall contain the input clock
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+                if unset, the default timeout is 30 seconds
+
+Example:
+	watchdog at 208a038 {
+		compatible = "qcom,kpss-wdt-ipq8064";
+		reg = <0x0208a038 0x40>;
+		clocks = <&sleep_clk>;
+		timeout-sec = <10>;
+	};
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
