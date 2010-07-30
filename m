From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 30 Jul 2010 17:24:54 +0800
Subject: [PATCH] arm: remove machine_desc.io_pg_offst and .phys_io
Message-ID: <1280481894.161711.978309737980.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're now using addruart to establish the debug mapping, we can
remove the io_pg_offst and phys_io members of struct machine_desc.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
Russell: for application once initialisers are gone

---
 arch/arm/include/asm/mach/arch.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..1f545fe 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -16,14 +16,10 @@ struct sys_timer;
 
 struct machine_desc {
 	/*
-	 * Note! The first four elements are used
+	 * Note! The first two elements are used
 	 * by assembler code in head.S, head-common.S
 	 */
 	unsigned int		nr;		/* architecture number	*/
-	unsigned int		phys_io;	/* start of physical io	*/
-	unsigned int		io_pg_offst;	/* byte offset for io 
-						 * page tabe entry	*/
-
 	const char		*name;		/* architecture name	*/
 	unsigned long		boot_params;	/* tagged list		*/
 
