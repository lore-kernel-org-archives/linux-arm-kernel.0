From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Dec 2016 13:58:08 +0900
Subject: [PATCH v2 2/5] PM / devfreq: exynos-bus: Add the detailed correlation
 for Exynos5433
In-Reply-To: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
References: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1481173091-9728-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the detailed corrleation between sub-blocks and VDD_INT power
line for Exynos5433. VDD_INT provided the power source to INT (Internal) block.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index d3ec8e676b6b..d6107770face 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -123,6 +123,21 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- FSYS
 		|--- FSYS2
 
+- In case of Exynos5433, there is VDD_INT power line as following:
+	VDD_INT |--- G2D_400 (parent device)
+		|--- G2D_266
+		|--- GSCL
+		|--- JPEG
+		|--- HEVC
+		|--- MFC
+		|--- MSCL
+		|--- NoC0
+		|--- NoC1
+		|--- NoC2
+		|--- PERIS (Fixed clock rate)
+		|--- PERIC (Fixed clock rate)
+		|--- FSYS  (Fixed clock rate)
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1
