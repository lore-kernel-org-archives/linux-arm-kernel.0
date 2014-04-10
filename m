From: lho@apm.com (Loc Ho)
Date: Thu, 10 Apr 2014 12:47:56 -0600
Subject: [PATCH v4 1/3] Documentation: Add documentation for the APM X-Gene
 SoC RTC DTS binding
In-Reply-To: <1397155678-26607-1-git-send-email-lho@apm.com>
References: <1397155678-26607-1-git-send-email-lho@apm.com>
Message-ID: <1397155678-26607-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the APM X-Gene SoC RTC DTS binding.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/rtc/xgene-rtc.txt          |   27 ++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/xgene-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/xgene-rtc.txt b/Documentation/devicetree/bindings/rtc/xgene-rtc.txt
new file mode 100644
index 0000000..2e9c503
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/xgene-rtc.txt
@@ -0,0 +1,27 @@
+* APM X-Gene Real Time Clock
+
+RTC controller for the APM X-Gene Real Time Clock
+
+Required properties:
+- compatible : Should be "apm,xgene-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the RTC.
+- clocks: Reference to the clock entry.
+
+Example:
+
+rtcclk: rtcclk {
+	compatible = "fixed-clock";
+	#clock-cells = <1>;
+	clock-frequency = <100000000>;
+	clock-output-names = "rtcclk";
+};
+
+rtc: rtc at 10510000 {
+	compatible = "apm,xgene-rtc";
+	reg = <0x0 0x10510000 0x0 0x400>;
+	interrupts = <0x0 0x46 0x4>;
+	#clock-cells = <1>;
+	clocks = <&rtcclk 0>;
+};
-- 
1.5.5
