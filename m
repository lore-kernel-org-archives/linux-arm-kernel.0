From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Mon, 14 Mar 2011 22:01:04 -0700
Subject: [PATCH 01/11] msm: dma: Guard for multiple file inclusion
In-Reply-To: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
References: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1300165274-8544-2-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subhash Jadavani <subhashj@codeaurora.org>

The include guard was missing the #define, leading to errors if one
included dma.h twice.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/dma.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/dma.h b/arch/arm/mach-msm/include/mach/dma.h
index 05583f5..ece09e0 100644
--- a/arch/arm/mach-msm/include/mach/dma.h
+++ b/arch/arm/mach-msm/include/mach/dma.h
@@ -1,6 +1,7 @@
 /* linux/include/asm-arm/arch-msm/dma.h
  *
  * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2011, Code Aurora Forum. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -14,6 +15,7 @@
  */
 
 #ifndef __ASM_ARCH_MSM_DMA_H
+#define __ASM_ARCH_MSM_DMA_H
 
 #include <linux/list.h>
 #include <mach/msm_iomap.h>
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
