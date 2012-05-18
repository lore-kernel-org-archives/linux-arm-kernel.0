From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:15 +0100
Subject: [PATCH 16/16] ARM: ux500: Re-enable SMSC911x platform code
 registration during non-DT boots
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch to disable SMSC911x registration was applied twice in the upstream
kernel by mistake. Git interpreted this as 'take the same entry from a
similar struct' which was close by. This was the wrong thing to do. This patch
rectifies this error and re-enables SMSC911x registration when Device Tree is
not enabled.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 33d47e1..2ddbb87 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -596,6 +596,7 @@ static void __init mop500_uart_init(struct device *parent)
 static struct platform_device *snowball_platform_devs[] __initdata = {
 	&snowball_led_dev,
 	&snowball_key_dev,
+	&snowball_sbnet_dev,
 	&ab8500_device,
 };
 
-- 
1.7.9.5
