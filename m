From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 17:28:48 +0200
Subject: [PATCH v2 1/4] arm: pxa: add device-tree irq init for pxa27x
In-Reply-To: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1413127731-1187-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initializer for irqs in a device-tree machine on a pxa27x.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa27x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index b040d7d..8ca62e2 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -398,6 +398,11 @@ void __init pxa27x_init_irq(void)
 	pxa_init_irq(34, pxa27x_set_wake);
 }
 
+void __init pxa27x_dt_init_irq(void)
+{
+	pxa_dt_irq_init(pxa27x_set_wake);
+}
+
 static struct map_desc pxa27x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
-- 
2.1.0
