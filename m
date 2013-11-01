From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 15:08:51 -0700
Subject: [PATCH 03/11] devicetree: bindings: Document qcom,kpss-acc
In-Reply-To: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383343739-23080-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kpss acc binding describes the clock, reset, and power domain
controller for a Krait CPU.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
new file mode 100644
index 0000000..ed4a9c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
@@ -0,0 +1,21 @@
+* Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
+
+The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
+There is one ACC register region per CPU within the KPSS remaped region as
+well as an alias register region that remaps accesses to the ACC associated
+with the CPU accessing the region.
+
+Required Properties:
+
+- compatible : Shall contain "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2".
+- reg: Specifies the base address and size of the banked register region.
+- cpu-offset : per-cpu offset used when the device is accessed without the
+		CPU remapping facilities.
+		The offset is cpu-offset + (0x10000 * cpu-nr).
+
+Example:
+
+	clock-controller at 2008000 {
+		compatible = "qcom,kpss-acc-v2";
+		reg = <0x02008000 0x1000>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
