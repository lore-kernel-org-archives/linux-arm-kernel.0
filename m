From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 11 Apr 2016 12:57:46 +0900
Subject: [PATCH v9 08/20] PM / devfreq: exynos: Add the detailed correlation
 between sub-blocks and power line
In-Reply-To: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460347078-15175-9-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos3250, Exynos4210 and Exynos4x12.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index 03f13d38f1a1..b098fa2ba5d4 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -53,6 +53,57 @@ Optional properties only for parent bus device:
 - exynos,voltage-tolerance: the percentage value for bus voltage tolerance
 			which is used to calculate the max voltage.
 
+Detailed correlation between sub-blocks and power line according to Exynos SoC:
+- In case of Exynos3250, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC
+		|--- G3D
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- FSYS
+		|--- LCD0
+		|--- PERIR
+		|--- ISP
+		|--- CAM
+
+- In case of Exynos4210, there is one power line as following:
+	VDD_INT |--- DMC (parent device)
+		|--- LEFTBUS
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- LCD0
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- LCD1
+
+- In case of Exynos4x12, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- IMAGE
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- ISP
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1
