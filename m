From: dwoo08.lee@samsung.com (Dongwoo Lee)
Date: Tue, 20 Jun 2017 16:12:24 +0900
Subject: [PATCH 2/2] arm64: dts: exynos: Add extcon property for TM2 and TM2E
In-Reply-To: <1497942745-8607-1-git-send-email-dwoo08.lee@samsung.com>
References: <1497942745-8607-1-git-send-email-dwoo08.lee@samsung.com>
 <CGME20170620071232epcas1p44dcc6475c7f826a8da52ad776759a926@epcas1p4.samsung.com>
Message-ID: <1497942745-8607-3-git-send-email-dwoo08.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9840354ff429 ("usb: dwc3: Add dual-role support") dwc3
node requires extcon property to be initialized as otg mode, and it
can support dual-role mode operation.

Signed-off-by: Dongwoo Lee <dwoo08.lee@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 477c3bc..4daca1e 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1204,6 +1204,7 @@
 
 &usbdrd_dwc3 {
 	dr_mode = "otg";
+	extcon = <&muic>;
 };
 
 &usbdrd30_phy {
-- 
1.9.1
