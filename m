From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:48 +0530
Subject: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yipeng Yao <ypyao@marvell.com>

Fix below warning message, coming from 64 bit toolchain.

drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Yipeng Yao <ypyao@marvell.com>
[vaibhav.hiremath at linaro.org: Updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 632008f..4c92694 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1116,7 +1116,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
-	*i2c_types = (u32)(of_id->data);
+
+	*i2c_types = (long)(of_id->data);
+
 	return 0;
 }
 
-- 
1.9.1
