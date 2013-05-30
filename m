From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 30 May 2013 15:27:45 +0200
Subject: [PATCH 5/5] mfd: ab8500-core: Add of_compatible property for
 ab8500-codec
In-Reply-To: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1369920465-13905-6-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_compatible string to the ab8500-codec cell to allow the driver to
grab handlers such as regulators from device-tree when available.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/ab8500-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 1863985..3efb356 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1120,6 +1120,7 @@ static struct mfd_cell ab8500_devs[] = {
 	},
 	{
 		.name = "ab8500-codec",
+		.of_compatible = "stericsson,ab8500-codec",
 	},
 };
 
-- 
1.8.2
