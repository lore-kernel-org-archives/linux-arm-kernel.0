From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Jan 2015 18:30:38 +0100
Subject: [PATCH 2/2] ARM: dts: Add syscon phandle to the video-phy node for
 Exynos4
In-Reply-To: <1421429438-32090-1-git-send-email-s.nawrocki@samsung.com>
References: <1421429438-32090-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421429438-32090-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required to fix regression after introducing the PMU device
nodes required for the PMU driver modified in commit
14fc8b93d47323561edf5d482d4a4b3ee1b90286
("ARM: EXYNOS: Add platform driver support for Exynos PMU").
This change is needed to make MIPI DSI displays and MIPI CSI-2
camera sensors working again on Exynos4 boards.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..250ee50 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -76,6 +76,7 @@
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		reg = <0x10020710 8>;
 		#phy-cells = <1>;
+		syscon = <&pmu_system_controller>;
 	};
 
 	pd_mfc: mfc-power-domain at 10023C40 {
-- 
1.7.9.5
