From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 17:42:45 +0000
Subject: [RFC PATCH 00/10] Make mach/irqs.h optional
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120113174245.GA30497@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:34:01AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series removes the include of mach/irqs.h from asm/irq.h when
> SPARSE_IRQ is selected. Platforms which select SPARSE_IRQ have been
> updated.
> 
> This breaks platforms where SPARSE_IRQ is user selectable. This is on
> purpose so that SPARSE_IRQ gets properly supported. We could push
> HAVE_SPARSE_IRQ option down to the platforms that select it if that is
> preferred. But as recent experience has shown, perhaps breaking platforms
> is the only way to get some platforms updated.

Nice one Rob!  Patch below to remove irqs.h for picoxcell too if you 
could add that one to your series.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie

8<---

>From 2d07b017bb06be86bd01686f98c699f1eff0ac10 Mon Sep 17 00:00:00 2001
From: Jamie Iles <jamie@jamieiles.com>
Date: Fri, 13 Jan 2012 17:40:05 +0000
Subject: [PATCH] ARM: picoxcell: remove mach/irqs.h

picoxcell uses SPARSE_IRQ which means we don't need a mach/irqs.h
anymore so kill it off.

Cc: Rob Herring <robherring2@gmail.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/irqs.h |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h

diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
deleted file mode 100644
index 59eac1e..0000000
--- a/arch/arm/mach-picoxcell/include/mach/irqs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-/* We dynamically allocate our irq_desc's. */
-#define NR_IRQS				0
-
-#endif /* __MACH_IRQS_H */
-- 
1.7.5.4
