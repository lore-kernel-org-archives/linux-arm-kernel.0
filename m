From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:44 +0000
Subject: [PATCH 04/26] mfd: ab8500-sysctrl.c: Provide charging as reset reason
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

It's possible to supply a string to provide a reason for
triggering a restart. In this case our reason is to enter
charging-only mode, as a charger was found to be present.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Karl KOMIEROWSKI <karl.komierowski@stericsson.com>
---
 drivers/mfd/ab8500-sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 26216e7..cf58f69 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -59,7 +59,7 @@ void ab8500_power_off(void)
 			       "Charger \"%s\" is connected with known battery."
 			       " Rebooting.\n",
 			       pss[i]);
-			machine_restart(NULL);
+			machine_restart("charging");
 		}
 	}
 
-- 
1.7.9.5
