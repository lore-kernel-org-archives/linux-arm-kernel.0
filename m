From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed,  9 Jan 2013 14:31:13 +0100
Subject: [PATCH RESEND] ARM: picoxcell: remove unnecessary header common.h
Message-ID: <1357738273-20842-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 66314223 ("ARM: socfpga: initial support for Altera's
SOCFPGA platform") struct sys_timer dw_apb_timer is an extern in
<linux/dw_apb_timer.h>, so there is no need for common.h anymore,
instead directly #include <asm/mach/time.h> in common.c

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Acked-by: Jamie Iles <jamie@jamieiles.com>
---

I looks like this hasn't made it into -next yet, thus I'm resending
the patch already submitted on 5 October 2012 (with Jamie's ACK added).

 arch/arm/mach-picoxcell/common.c |    3 +--
 arch/arm/mach-picoxcell/common.h |   17 -----------------
 2 files changed, 1 insertions(+), 19 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/common.h

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index f6c0849..bc36f12 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -19,8 +19,7 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
-
-#include "common.h"
+#include <asm/mach/time.h>
 
 #define PHYS_TO_IO(x)			(((x) & 0x00ffffff) | 0xfe000000)
 #define PICOXCELL_PERIPH_BASE		0x80000000
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
deleted file mode 100644
index a65cb02..0000000
--- a/arch/arm/mach-picoxcell/common.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * All enquiries to support at picochip.com
- */
-#ifndef __PICOXCELL_COMMON_H__
-#define __PICOXCELL_COMMON_H__
-
-#include <asm/mach/time.h>
-
-extern struct sys_timer dw_apb_timer;
-
-#endif /* __PICOXCELL_COMMON_H__ */
-- 
1.7.5.4
