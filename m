From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:47 +0000
Subject: [PATCH 07/26] mfd: ab8500-sysctrl: export read/write symbols
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Export ab8500_sysctrl_read() and ab8500_sysctrl_write() symobols.

They will be used by LTP test cases.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
---
 drivers/mfd/ab8500-sysctrl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 19a024e..5a61e94 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -94,6 +94,7 @@ int ab8500_sysctrl_read(u16 reg, u8 *value)
 	return abx500_get_register_interruptible(sysctrl_dev, bank,
 		(u8)(reg & 0xFF), value);
 }
+EXPORT_SYMBOL(ab8500_sysctrl_read);
 
 int ab8500_sysctrl_write(u16 reg, u8 mask, u8 value)
 {
@@ -109,6 +110,7 @@ int ab8500_sysctrl_write(u16 reg, u8 mask, u8 value)
 	return abx500_mask_and_set_register_interruptible(sysctrl_dev, bank,
 		(u8)(reg & 0xFF), mask, value);
 }
+EXPORT_SYMBOL(ab8500_sysctrl_write);
 
 static int __devinit ab8500_sysctrl_probe(struct platform_device *pdev)
 {
-- 
1.7.9.5
