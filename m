From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 15:08:49 -0700
Subject: [PATCH 01/11] devicetree: bindings: Document cpu enable-method for
 ARM CPUs
In-Reply-To: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383343739-23080-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

According to the ePAPR CPUs should have an enable method. On ARM
the enable-method property has not been used so far, so document
this property as an optional property and add the spin-table
method as one value

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
[sboyd: Split off into separate patch]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..37258f9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -45,6 +45,14 @@ For the ARM architecture every CPU node must contain the following properties:
 		"marvell,xsc3"
 		"marvell,xscale"
 
+And the following optional properties:
+
+- enable-method: Specifies the method used to enable or take the secondary cores
+		 out of reset. This allows different reset sequence for
+		 different types of cpus.
+		 This should be one of:
+		 "spin-table"
+
 Example:
 
 	cpus {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
