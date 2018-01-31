From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 31 Jan 2018 14:44:32 +0100
Subject: [RFC PATCH v2 2/5] arm64: dts: exynos: add micro-USB connector node
 to TM2 platforms
In-Reply-To: <20180131134435.12216-1-a.hajda@samsung.com>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134458eucas1p1f611f9e3345b9e3bd5b18b6d57ff21f1@eucas1p1.samsung.com>
Message-ID: <20180131134435.12216-3-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since USB connector bindings are available we can describe it on TM2(e).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e93d91a3ed..e5a6a2303060 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -798,6 +798,12 @@
 
 		muic: max77843-muic {
 			compatible = "maxim,max77843-muic";
+
+			musb_con: musb_connector {
+				compatible = "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+			};
 		};
 
 		regulators {
-- 
2.15.1
