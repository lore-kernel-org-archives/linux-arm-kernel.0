From: andy.tang@nxp.com (Yuantian Tang)
Date: Mon, 20 Mar 2017 10:37:22 +0800
Subject: [PATCH 1/2 v2] dt-bindings: qoriq-clock: Add coreclk
Message-ID: <1489977443-33582-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Wood <oss@buserror.net>

ls1012a has separate input root clocks for core PLLs versus the platform
PLL, with the latter described as sysclk in the hw docs.
Update the qoriq-clock binding to allow a second input clock, named
"coreclk".  If present, this clock will be used for the core PLLs.

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
	-- change the author to Scott
 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index aa3526f..119cafd 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -56,6 +56,11 @@ Optional properties:
 - clocks: If clock-frequency is not specified, sysclk may be provided
 	as an input clock.  Either clock-frequency or clocks must be
 	provided.
+	A second input clock, called "coreclk", may be provided if
+	core PLLs are based on a different input clock from the
+	platform PLL.
+- clock-names: Required if a coreclk is present.  Valid names are
+	"sysclk" and "coreclk".
 
 2. Clock Provider
 
@@ -72,6 +77,7 @@ second cell is the clock index for the specified type.
 	2	hwaccel		index (n in CLKCGnHWACSR)
 	3	fman		0 for fm1, 1 for fm2
 	4	platform pll	0=pll, 1=pll/2, 2=pll/3, 3=pll/4
+	5	coreclk		must be 0
 
 3. Example
 
-- 
2.1.0.27.g96db324
