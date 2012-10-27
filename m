From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:46 +0530
Subject: [PATCH 1/9] pinctrl: SPEAr: Don't update all non muxreg bits on
 pinctrl_disable
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <94543a207ee39bfd5b58607f380681b1b7b0b503.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all bits of a register are used for pinctrl in SPEAr. So only update bits
relevant to pinctrl using muxreg->mask.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 5d4f44f..b1fd6ee 100644
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
1.7.12.rc2.18.g61b472e
