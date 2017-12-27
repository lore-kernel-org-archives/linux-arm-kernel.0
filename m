From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Dec 2017 15:51:40 +0100
Subject: [PATCH 07/12] ARM: davinci: drop unneeded newline
In-Reply-To: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1514386305-7402-8-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_request uses its second argument as a label, so it doesn't seem
appropriate for it to have a newline.  Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-davinci/board-da850-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index cbde003..d898a94 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -798,11 +798,11 @@ static int da850_lcd_hw_init(void)
 {
 	int status;
 
-	status = gpio_request(DA850_LCD_BL_PIN, "lcd bl\n");
+	status = gpio_request(DA850_LCD_BL_PIN, "lcd bl");
 	if (status < 0)
 		return status;
 
-	status = gpio_request(DA850_LCD_PWR_PIN, "lcd pwr\n");
+	status = gpio_request(DA850_LCD_PWR_PIN, "lcd pwr");
 	if (status < 0) {
 		gpio_free(DA850_LCD_BL_PIN);
 		return status;
