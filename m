From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 2 Apr 2012 09:00:38 +0530
Subject: [PATCH] fixup! pinctrl: Replace list_*() with get_*_count()
In-Reply-To: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
References: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
Message-ID: <dbb0162aa10ba58f9630dac07d875e696862a691.1333337290.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

This is an incremental patch over patch mentioned in subject. Please squash it
with earlier one while applying.

ngroup check for tegra was still present at some places, that was mentioned by
stephen.
---
 drivers/pinctrl/pinctrl-tegra.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index 774f7fd..41311a2 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -158,8 +158,6 @@ static void tegra_pinctrl_disable(struct pinctrl_dev *pctldev,
 	const struct tegra_pingroup *g;
 	u32 val;
 
-	if (group >= pmx->soc->ngroups)
-		return;
 	g = &pmx->soc->groups[group];
 
 	if (g->mux_reg < 0)
@@ -302,8 +300,6 @@ static int tegra_pinconf_group_get(struct pinctrl_dev *pctldev,
 	s16 reg;
 	u32 val, mask;
 
-	if (group >= pmx->soc->ngroups)
-		return -EINVAL;
 	g = &pmx->soc->groups[group];
 
 	ret = tegra_pinconf_reg(pmx, g, param, &bank, &reg, &bit, &width);
@@ -331,8 +327,6 @@ static int tegra_pinconf_group_set(struct pinctrl_dev *pctldev,
 	s16 reg;
 	u32 val, mask;
 
-	if (group >= pmx->soc->ngroups)
-		return -EINVAL;
 	g = &pmx->soc->groups[group];
 
 	ret = tegra_pinconf_reg(pmx, g, param, &bank, &reg, &bit, &width);
-- 
1.7.9
