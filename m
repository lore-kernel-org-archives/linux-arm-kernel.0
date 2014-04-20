From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 16:54:01 +0530
Subject: [PATCH 4/7] ARM: dtsi: add access to simple hdmiphy to exynos5420 hdmi
 node
In-Reply-To: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397993044-14564-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

add reference for hdmiphy phy to the client node, which is
hdmi for exynos5420.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    2 ++
 1 file changed, 2 insertions(+)
 mode change 100755 => 100644 arch/arm/boot/dts/exynos5420.dtsi

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
old mode 100755
new mode 100644
index 07a6cdc..398cb20
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -642,6 +642,8 @@
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
 		status = "disabled";
+		phys = <&simple_phys 0>;
+		phy-names = "hdmiphy";
 	};
 
 	mixer at 14450000 {
-- 
1.7.9.5
