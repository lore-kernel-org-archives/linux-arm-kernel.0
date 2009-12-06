From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 6 Dec 2009 21:55:38 +0100
Subject: HTC Dream: dream is better name for this machine
In-Reply-To: <20091206205041.GA12555@elf.ucw.cz>
References: <20091206205041.GA12555@elf.ucw.cz>
Message-ID: <20091206205538.GA13811@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Sorry, previous patch will not apply; I messed the trees. This one
should work.]

---

While few people may know HTC Dream by its codename, it is better to
use name of released hardware in the sources.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-msm/board-dream.c b/arch/arm/mach-msm/board-dream.c
index 21afa85..d238e2c 100644
--- a/arch/arm/mach-msm/board-dream.c
+++ b/arch/arm/mach-msm/board-dream.c
@@ -12,6 +12,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
+ * This machine is also known by its codename, "trout".
  */
 
 #include <linux/kernel.h>
@@ -40,12 +41,12 @@ static struct platform_device *devices[] __initdata = {
 
 extern struct sys_timer msm_timer;
 
-static void __init trout_init_irq(void)
+static void __init dream_init_irq(void)
 {
 	msm_init_irq();
 }
 
-static void __init trout_fixup(struct machine_desc *desc, struct tag *tags,
+static void __init dream_fixup(struct machine_desc *desc, struct tag *tags,
 				char **cmdline, struct meminfo *mi)
 {
 	mi->nr_banks = 1;
@@ -54,12 +55,12 @@ static void __init trout_fixup(struct machine_desc *desc, struct tag *tags,
 	mi->bank[0].size = (101*1024*1024);
 }
 
-static void __init trout_init(void)
+static void __init dream_init(void)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
-static struct map_desc trout_io_desc[] __initdata = {
+static struct map_desc dream_io_desc[] __initdata = {
 	{
 		.virtual = TROUT_CPLD_BASE,
 		.pfn     = __phys_to_pfn(TROUT_CPLD_START),
@@ -68,10 +69,10 @@ static struct map_desc trout_io_desc[] __initdata = {
 	}
 };
 
-static void __init trout_map_io(void)
+static void __init dream_map_io(void)
 {
 	msm_map_common_io();
-	iotable_init(trout_io_desc, ARRAY_SIZE(trout_io_desc));
+	iotable_init(dream_io_desc, ARRAY_SIZE(dream_io_desc));
 
 #ifdef CONFIG_MSM_DEBUG_UART3
 	/* route UART3 to the "H2W" extended usb connector */
@@ -85,9 +86,9 @@ MACHINE_START(TROUT, "HTC Dream")
 	.phys_io	= MSM_DEBUG_UART_PHYS,
 	.io_pg_offst	= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
-	.fixup		= trout_fixup,
-	.map_io		= trout_map_io,
-	.init_irq	= trout_init_irq,
-	.init_machine	= trout_init,
+	.fixup		= dream_fixup,
+	.map_io		= dream_map_io,
+	.init_irq	= dream_init_irq,
+	.init_machine	= dream_init,
 	.timer		= &msm_timer,
 MACHINE_END

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
