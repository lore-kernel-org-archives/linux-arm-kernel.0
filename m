From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 15:08:50 -0700
Subject: [PATCH 02/11] devicetree: bindings: Document Qualcomm cpus and
 enable-method
In-Reply-To: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383343739-23080-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

Scorpion and Krait are Qualcomm cpus. These cpus don't use the
spin-table enable-method. Instead they rely on mmio register
accesses to enable power and clocks to bring CPUs out of reset.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
[sboyd: Split off into separate patch, renamed method to
qcom,mmio]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This slightly conflicts with my krait EDAC series.

 Documentation/devicetree/bindings/arm/cpus.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 37258f9..e2969fa2 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -44,6 +44,8 @@ For the ARM architecture every CPU node must contain the following properties:
 		"marvell,mohawk"
 		"marvell,xsc3"
 		"marvell,xscale"
+		"qcom,scorpion"
+		"qcom,krait"
 
 And the following optional properties:
 
@@ -52,6 +54,7 @@ And the following optional properties:
 		 different types of cpus.
 		 This should be one of:
 		 "spin-table"
+		 "qcom,mmio"
 
 Example:
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
