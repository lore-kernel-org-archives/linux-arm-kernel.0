From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:14:07 +0800
Subject: [PATCH v2 8/8] arm/mxs: move MXS_GPIO_NR into mach/mxs.h
In-Reply-To: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313252047-8820-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch moves MXS_GPIO_NR into mach/mxs.h, so that mach/gpio.h
becomes an empty header and can wait for a global removal from
asm/gpio.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/gpio.h |   26 +-------------------------
 arch/arm/mach-mxs/include/mach/mxs.h  |    2 ++
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index 8aea2ec..40a8c17 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -1,25 +1 @@
-/*
- * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#ifndef __MACH_MXS_GPIO_H__
-#define __MACH_MXS_GPIO_H__
-
-#define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
-
-#endif /* __MACH_MXS_GPIO_H__ */
+/* empty */
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 35a89dd..5aa5f75 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -86,6 +86,8 @@
 	.type = _type,							\
 }
 
+#define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
+
 #define MXS_SET_ADDR		0x4
 #define MXS_CLR_ADDR		0x8
 #define MXS_TOG_ADDR		0xc
-- 
1.7.4.1
