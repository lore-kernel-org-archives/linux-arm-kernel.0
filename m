From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 21 Feb 2018 09:55:38 +0100
Subject: [PATCH v4 3/6] arm64: dts: exynos: add micro-USB connector node to
 TM2 platforms
In-Reply-To: <20180221085541.14556-1-a.hajda@samsung.com>
References: <20180221085541.14556-1-a.hajda@samsung.com>
 <CGME20180221085605eucas1p1b2da327fbaaf9851e2407e1d2a39c370@eucas1p1.samsung.com>
Message-ID: <20180221085541.14556-4-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since USB connector bindings are available we can describe it on TM2(e).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 0b61dda99569..f604f6b1a9c2 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -836,6 +836,13 @@
 
 		muic: max77843-muic {
 			compatible = "maxim,max77843-muic";
+
+			musb_con: musb_connector {
+				compatible = "samsung,usb-connector-11pin",
+					     "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+			};
 		};
 
 		regulators {
-- 
2.16.1
