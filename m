From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 15 Feb 2018 11:39:17 +0100
Subject: [RFC PATCH v2 3/6] arm64: dts: exynos: add micro-USB connector node
 to TM2 platforms
In-Reply-To: <20180215103920.32017-1-a.hajda@samsung.com>
References: <20180215103920.32017-1-a.hajda@samsung.com>
 <CGME20180215103927eucas1p1009da1dfa940fa3a39e29c8d0894f305@eucas1p1.samsung.com>
Message-ID: <20180215103920.32017-4-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since USB connector bindings are available we can describe it on TM2(e).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e93d91a3ed..7e49fadee412 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -798,6 +798,13 @@
 
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
