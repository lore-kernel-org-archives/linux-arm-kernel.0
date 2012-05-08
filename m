From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:10:25 +0530
Subject: [PATCH V3 1/5] pinctrl: SPEAr: Don't set all non muxreg bits on
 pinctrl_disable
In-Reply-To: <cover.1336448307.git.viresh.kumar@st.com>
References: <cover.1336448307.git.viresh.kumar@st.com>
Message-ID: <ab4d38bd8161fe5b28b8441c6e6b0f37896cbd60.1336448307.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 5ae50aa..8653569 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -244,7 +244,7 @@ static int spear_pinctrl_endisable(struct pinctrl_dev *pctldev,
 			else
 				temp = ~muxreg->val;
 
-			val |= temp;
+			val |= muxreg->mask & temp;
 			pmx_writel(pmx, val, muxreg->reg);
 		}
 	}
-- 
1.7.9
