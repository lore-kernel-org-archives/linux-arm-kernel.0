From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:10 +0100
Subject: [PATCH 04/19] mfd: mcp-core: Fix 'blank line after declarations'
 warning
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Missing a blank line after declarations
+       unsigned long flags;
+       spin_lock_irqsave(&mcp->lock, flags);

total: 0 errors, 1 warnings, 238 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mcp-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 62e5e36..7f5066e 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -137,6 +137,7 @@ EXPORT_SYMBOL(mcp_reg_read);
 void mcp_enable(struct mcp *mcp)
 {
 	unsigned long flags;
+
 	spin_lock_irqsave(&mcp->lock, flags);
 	if (mcp->use_count++ == 0)
 		mcp->ops->enable(mcp);
-- 
1.8.3.2
