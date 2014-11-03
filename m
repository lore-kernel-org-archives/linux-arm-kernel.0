From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon,  3 Nov 2014 18:41:59 +0100
Subject: [PATCH v3 1/4] arm: pxa: add device-tree irq init for pxa27x
In-Reply-To: <1415036522-7800-1-git-send-email-robert.jarzmik@free.fr>
References: <1415036522-7800-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1415036522-7800-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initializer for irqs in a device-tree machine on a pxa27x.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Arnd Bergmann <arnd@arndb.de>

---
Since v2: added if (IS_ENABLED(CONFIG_OF)) for non device-tree builds
---
 arch/arm/mach-pxa/pxa27x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index b040d7d..af423a4 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -398,6 +398,12 @@ void __init pxa27x_init_irq(void)
 	pxa_init_irq(34, pxa27x_set_wake);
 }
 
+void __init pxa27x_dt_init_irq(void)
+{
+	if (IS_ENABLED(CONFIG_OF))
+		pxa_dt_irq_init(pxa27x_set_wake);
+}
+
 static struct map_desc pxa27x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
-- 
2.1.0
