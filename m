From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  9 Jul 2017 19:36:14 +0300
Subject: [PATCH] ARM: tegra: Register host1x node with iommu binding on
 tegra124
Message-ID: <20170709163614.6746-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the host1x node with the SMMU (as HC swgroup) to allow
the host1x code to attach to it. It avoid failing the probe sequence,
which resulted in the tegra drm driver not probing and thus nothing
being displayed on-screen.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 187a36c6d0fc..b3b89befffeb 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -85,6 +85,7 @@
 		clocks = <&tegra_car TEGRA124_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		iommus = <&mc TEGRA_SWGROUP_HC>;
 
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.13.1
