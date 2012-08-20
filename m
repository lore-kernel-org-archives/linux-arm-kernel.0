From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 20 Aug 2012 13:49:39 +0800
Subject: [PATCH 3/3] ARM: pxa: fix build issue while CONFIG_OF is disabled
In-Reply-To: <1345441779-22632-1-git-send-email-haojian.zhuang@gmail.com>
References: <1345441779-22632-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1345441779-22632-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-pxa/built-in.o: In function `pxa3xx_dt_init_irq':
saar.c:(.init.text+0x604): undefined reference to `pxa_dt_irq_init'

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-pxa/pxa3xx.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4a9d04a..ff9c957 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -402,11 +402,13 @@ void __init pxa3xx_init_irq(void)
 	pxa_init_irq(56, pxa3xx_set_wake);
 }
 
+#ifdef CONFIG_OF
 void __init pxa3xx_dt_init_irq(void)
 {
 	__pxa3xx_init_irq();
 	pxa_dt_irq_init(pxa3xx_set_wake);
 }
+#endif	/* CONFIG_OF */
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
-- 
1.7.9.5
