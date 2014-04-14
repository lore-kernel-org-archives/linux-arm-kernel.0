From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Apr 2014 15:33:41 -0600
Subject: [PATCH 3/4] pinctrl: tegra: reduce size of data table fields
In-Reply-To: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1397511222-28533-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The range of npins and function ID values is small enough to fit into a
u8. Use this type rather than unsigned to shrink the pinmux data tables.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra.h b/drivers/pinctrl/pinctrl-tegra.h
index c60ad4cf971c..9052c1f8a59b 100644
--- a/drivers/pinctrl/pinctrl-tegra.h
+++ b/drivers/pinctrl/pinctrl-tegra.h
@@ -131,8 +131,8 @@ struct tegra_function {
 struct tegra_pingroup {
 	const char *name;
 	const unsigned *pins;
-	unsigned npins;
-	unsigned funcs[4];
+	u8 npins;
+	u8 funcs[4];
 	s16 mux_reg;
 	s16 pupd_reg;
 	s16 tri_reg;
-- 
1.8.1.5
