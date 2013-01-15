From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:45 +0000
Subject: [PATCH 05/26] mfd: ab8500-gpadc: Change to mdelay for greater
 resolution
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

The resolution of msleep is related to HZ, so with HZ set to
100 any msleep of less than 10ms will become ~10ms.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Bibek BASU <bibek.basu@stericsson.com>
Tested-by: Bibek BASU <bibek.basu@stericsson.com>
---
 drivers/mfd/ab8500-gpadc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 29d72a2..3883b93 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -344,7 +344,7 @@ int ab8500_gpadc_read_raw(struct ab8500_gpadc *gpadc, u8 channel)
 		  * Delay might be needed for ABB8500 cut 3.0, if not, remove
 		  * when hardware will be available
 		  */
-			msleep(1);
+			mdelay(1);
 			break;
 		}
 		/* Intentional fallthrough */
-- 
1.7.9.5
