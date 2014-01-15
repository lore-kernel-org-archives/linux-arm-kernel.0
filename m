From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 09:55:34 -0800
Subject: [PATCH v2 6/7] devicetree: bindings: Document Krait performance
 monitor units (PMU)
In-Reply-To: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
References: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389808535-23852-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Krait PMU compatible string.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 3e1e498fea96..ce731441e64f 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -16,7 +16,14 @@ Required properties:
 	"arm,arm11mpcore-pmu"
 	"arm,arm1176-pmu"
 	"arm,arm1136-pmu"
-- interrupts : 1 combined interrupt or 1 per core.
+	"qcom,krait-pmu"
+- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
+               interrupt (PPI) then 1 interrupt should be specified.
+
+Optional properties:
+
+- qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
+                     events.
 
 Example:
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
