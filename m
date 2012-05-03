From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:42:03 +0530
Subject: [PATCH V2 1/5] pinctrl: SPEAr: Don't set all non muxreg bits on
 pinctrl_disable
In-Reply-To: <cover.1336039716.git.viresh.kumar@st.com>
References: <cover.1336039716.git.viresh.kumar@st.com>
Message-ID: <132ed5d6e5424e87474ed01dae1a09db30b3cc81.1336039716.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
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
