From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  5 Jan 2011 05:05:10 +0300
Subject: [PATCH 6/6] Fix eseries compilation if w100fb is not compiled in
	kernel
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1294193110-23958-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e800_tg_change depends on w100fb_gpio_read/write API which is only present
if w100fb is compiled in kernel.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>
---
 arch/arm/mach-pxa/eseries.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index b25690c..ed2c157 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -829,6 +829,7 @@ static struct w100_mem_info e800_w100_mem_info = {
 
 static void e800_tg_change(struct w100fb_par *par)
 {
+#ifdef FB_W100
 	unsigned long tmp;
 
 	tmp = w100fb_gpio_read(W100_GPIO_PORT_A);
@@ -837,6 +838,7 @@ static void e800_tg_change(struct w100fb_par *par)
 	else
 		tmp &= ~0x100;
 	w100fb_gpio_write(W100_GPIO_PORT_A, tmp);
+#endif
 }
 
 static struct w100_tg_info e800_tg_info = {
-- 
1.7.2.3
