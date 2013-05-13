From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 13:47:31 -0600
Subject: [PATCH] ARM: tegra: fix memory size on Beaver
Message-ID: <1368474451-11176-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra30's boot ROM masks the top 1MiB of RAM. Fix the memory node in
Beaver's DT file to reflect this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 47b0865..87f0cf5 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -7,7 +7,7 @@
 	compatible = "nvidia,beaver", "nvidia,tegra30";
 
 	memory {
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0x7ff00000>;
 	};
 
 	pinmux {
-- 
1.7.10.4
