From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Wed, 15 Feb 2017 13:47:35 +0800
Subject: [PATCH 1/2] dt-bindings: qoriq-clock: Add coreclk
Message-ID: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

ls1012a has separate input root clocks for core PLLs versus the platform
PLL, with the latter described as sysclk in the hw docs.
Update the qoriq-clock binding to allow a second input clock, named
"coreclk".  If present, this clock will be used for the core PLLs.

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index df9cb5a..97a9666 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -55,6 +55,11 @@ Optional properties:
 - clocks: If clock-frequency is not specified, sysclk may be provided
 	as an input clock.  Either clock-frequency or clocks must be
 	provided.
+	A second input clock, called "coreclk", may be provided if
+	core PLLs are based on a different input clock from the
+	platform PLL.
+- clock-names: Required if a coreclk is present.  Valid names are
+	"sysclk" and "coreclk".
 
 2. Clock Provider
 
@@ -71,6 +76,7 @@ second cell is the clock index for the specified type.
 	2	hwaccel		index (n in CLKCGnHWACSR)
 	3	fman		0 for fm1, 1 for fm2
 	4	platform pll	0=pll, 1=pll/2, 2=pll/3, 3=pll/4
+	5	coreclk		must be 0
 
 3. Example
 
-- 
2.1.0.27.g96db324
