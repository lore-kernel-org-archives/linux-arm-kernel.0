From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 10:58:26 +0530
Subject: [PATCH 2/6] ARM: dts: add clocks to hdmi dt node for exynos5250
In-Reply-To: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754110-31084-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix wrong clock numbers in hdmi dt node. Removed hdmiphy
clock which was a dummy clock earlier and not required now.
Also added mux clock to change the clock parent.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index dcb6c03..19c8174 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -612,10 +612,10 @@
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
-		clocks = <&clock 333>, <&clock 136>, <&clock 137>,
-				<&clock 333>, <&clock 333>;
+		clocks = <&clock 344>, <&clock 136>, <&clock 137>,
+				<&clock 159>, <&clock 1024>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
-				"sclk_hdmiphy", "hdmiphy";
+				"sclk_hdmiphy", "mout_hdmi";
 	};
 
 	mixer {
-- 
1.7.10.4
