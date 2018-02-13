From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 13 Feb 2018 12:40:39 -0800
Subject: [PATCH 2/3] memory: brcmstb: dpfe: fix type declaration of variable
 "ret"
In-Reply-To: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
Message-ID: <1518554440-21805-3-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some functions, variable "ret" should be ssize_t, so we fix it.

Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 088153760e52..2013a91217a9 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -507,7 +507,7 @@ static ssize_t show_info(struct device *dev, struct device_attribute *devattr,
 {
 	u32 response[MSG_FIELD_MAX];
 	unsigned int info;
-	int ret;
+	ssize_t ret;
 
 	ret = generic_show(DPFE_CMD_GET_INFO, response, dev, buf);
 	if (ret)
@@ -531,7 +531,7 @@ static ssize_t show_refresh(struct device *dev,
 	unsigned int offset;
 	u8 refresh, sr_abort, ppre, thermal_offs, tuf;
 	u32 mr4;
-	int ret;
+	ssize_t ret;
 
 	ret = generic_show(DPFE_CMD_GET_REFRESH, response, dev, buf);
 	if (ret)
@@ -588,7 +588,7 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	struct private_data *priv;
 	void __iomem *info;
 	unsigned int offset;
-	int ret;
+	ssize_t ret;
 
 	ret = generic_show(DPFE_CMD_GET_VENDOR, response, dev, buf);
 	if (ret)
-- 
2.7.4
