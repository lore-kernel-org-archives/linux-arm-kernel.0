From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:10 +0530
Subject: [PATCH 45/50] pinctrl: st: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-46-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: kernel at stlinux.com
---
 drivers/pinctrl/pinctrl-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index cab66c6..d0ba968 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1724,7 +1724,7 @@ static int st_pctl_probe(struct platform_device *pdev)
 	pctl_desc->confops	= &st_confops;
 	pctl_desc->name		= dev_name(&pdev->dev);
 
-	info->pctl = pinctrl_register(pctl_desc, &pdev->dev, info);
+	info->pctl = devm_pinctrl_register(&pdev->dev, pctl_desc, info);
 	if (IS_ERR(info->pctl)) {
 		dev_err(&pdev->dev, "Failed pinctrl registration\n");
 		return PTR_ERR(info->pctl);
-- 
2.1.4
