From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 09:43:02 +0530
Subject: [PATCH v2 Resend 2/2] ARM: dts: Add secure firmware support for
 Arndale-octa
In-Reply-To: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
References: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401250382-24046-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tushar Behera <tushar.behera@linaro.org>

Arndale-Octa board is always configured to work with trustzone
firmware binary. Added DTS node entry to enable this support.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 6ee8149fd5c4..434fd9d3e09d 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -26,6 +26,11 @@
 		bootargs = "console=ttySAC3,115200";
 	};
 
+	firmware at 02073000 {
+		compatible = "samsung,secure-firmware";
+		reg = <0x02073000 0x1000>;
+	};
+
 	fixed-rate-clocks {
 		oscclk {
 			compatible = "samsung,exynos5420-oscclk";
-- 
1.7.9.5
