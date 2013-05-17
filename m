From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 17 May 2013 18:24:31 +0200
Subject: [PATCH 5/6] pinctrl: samsung: Allow per-bank SoC-specific private data
In-Reply-To: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368807872-2601-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends pin bank descriptor structure with SoC-specific
private data field that allows SoC-specific drivers to store their own
private data.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b316d9f..26d3519 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -139,6 +139,7 @@ struct samsung_pin_bank {
 	u32		eint_mask;
 	u32		eint_offset;
 	char		*name;
+	void		*soc_priv;
 	struct device_node *of_node;
 	struct samsung_pinctrl_drv_data *drvdata;
 	struct irq_domain *irq_domain;
-- 
1.8.2.1
