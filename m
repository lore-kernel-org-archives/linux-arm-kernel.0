From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:03:59 +0400
Subject: [PATCH 01/20] SA1100: h3100/h3600: mark *_mach_init functions as
	__init
In-Reply-To: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 2f6ea17..ebb3b8d 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -188,7 +188,7 @@ static struct sa1100_port_fns h3xxx_port_fns __initdata = {
 };
 
 
-static void h3xxx_mach_init(void)
+static void __init h3xxx_mach_init(void)
 {
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
@@ -371,7 +371,7 @@ static struct gpio_default_state h3100_default_gpio[] = {
 	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
 };
 
-static void h3100_mach_init(void)
+static void __init h3100_mach_init(void)
 {
 	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
 	h3xxx_mach_init();
@@ -500,7 +500,7 @@ static struct gpio_default_state h3600_default_gpio[] = {
 	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
 };
 
-static void h3600_mach_init(void)
+static void __init h3600_mach_init(void)
 {
 	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
 	h3xxx_mach_init();
-- 
1.6.5.1.63.ga9d7.dirty
