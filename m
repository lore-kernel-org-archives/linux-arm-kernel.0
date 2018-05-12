From: collinsd@codeaurora.org (David Collins)
Date: Fri, 11 May 2018 18:46:46 -0700
Subject: [PATCH 1/2] regulator: of: add property for allowed modes
 specification
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
Message-ID: <f3aa166ddd11c8f9813602be68aa5b10e5c90979.1526088289.git.collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a common device tree property for regulator nodes to support
the specification of allowed operating modes.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b..c627aa0 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -59,6 +59,11 @@ Optional properties:
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
+- regulator-allowed-modes: list of operating modes that software is allowed to
+  configure for the regulator at run-time.  Elements may be specified in any
+  order.  The set of possible operating modes depends on the capabilities of
+  every hardware so each device binding document explains which values the
+  regulator supports.
 - regulator-system-load: Load in uA present on regulator that is not captured by
   any consumer request.
 - regulator-pull-down: Enable pull down resistor when the regulator is disabled.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
