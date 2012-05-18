From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:01 +0100
Subject: [PATCH 02/16] ARM: ux500: Enable LED heartbeat functionality on
 Snowball
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the user LED on Snowball to double flash
every second or so, whilst it's still alive. This can give key
indications as to what the board is doing in the case of no
console output.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index de94b2d..8845286 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -57,7 +57,7 @@
 static struct gpio_led snowball_led_array[] = {
 	{
 		.name = "user_led",
-		.default_trigger = "none",
+		.default_trigger = "heartbeat",
 		.gpio = 142,
 	},
 };
-- 
1.7.9.5
