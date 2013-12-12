From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 15:00:38 -0700
Subject: [PATCH] ARM: tegra: use PULL_NONE for Venice2 UART pins
Message-ID: <1386885638-29320-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Other boards use PULL_NONE for their debug UART pins, and without this
change, the board doesn't accept any serial input.

Fixes: 605ae5804385 ("ARM: tegra: add default pinctrl nodes for Venice2")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 616759c3c7e5..228fe5d05fdc 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -250,7 +250,7 @@
 					      "pu3";
 				nvidia,function = "uarta";
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			uart2_cts_n_pj5 {
-- 
1.8.1.5
