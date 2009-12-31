From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Thu, 31 Dec 2009 15:32:02 -0500 (EST)
Subject: [PATCH] ARM: Simplify param.h by simply including
	<asm-generic/param.h>.
Message-ID: <alpine.LFD.2.00.0912311531080.6866@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/arm/include/asm/param.h b/arch/arm/include/asm/param.h
index 8b24bf9..965d454 100644
--- a/arch/arm/include/asm/param.h
+++ b/arch/arm/include/asm/param.h
@@ -1,31 +1 @@
-/*
- *  arch/arm/include/asm/param.h
- *
- *  Copyright (C) 1995-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_PARAM_H
-#define __ASM_PARAM_H
-
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* User interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#else
-# define HZ		100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP         (-1)
-#endif
-
-/* max length of hostname */
-#define MAXHOSTNAMELEN  64
-
-#endif
-
+#include <asm-generic/param.h>

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
