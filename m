From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 16:28:33 +0200
Subject: [RFC PATCH 02/16] pinctrl: samsung: Detect and handle unsupported
 configuration types
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348842527-22460-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index dd108a9..c660fa5 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -391,6 +391,9 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 		return -EINVAL;
 	}
 
+	if (!width)
+		return -EINVAL;
+
 	mask = (1 << width) - 1;
 	shift = pin_offset * width;
 	data = readl(reg_base + cfg_reg);
-- 
1.7.12
