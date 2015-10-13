From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 13 Oct 2015 18:43:46 +0530
Subject: [PATCH v3 4/8] ARM: dts: add SROM device node for exynos4
In-Reply-To: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
References: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1444742030-31892-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node of SROM controller for exynos4.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3184e10..2f31f77 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -76,6 +76,11 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x10>;
+	};
+
 	mipi_phy: video-phy at 10020710 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		#phy-cells = <1>;
-- 
2.4.5
