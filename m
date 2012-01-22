From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:31 +0100
Subject: [RFC PATCH 05/11] ARM: provide XIP_VIRT_ADDR for no-MMU builds
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

XIP_VIRT_ADDR is needed for XIP builds and currently only defined for
builds with CONFIG_MMU.

Also provide it for no-MMU builds to make it possible to build an XIP
kernel for MMU-less machines. As these lack an MMU it has to be an
identity mapping.

Forwarded: id:1323467451-12128-1-git-send-email-u.kleine-koenig at pengutronix.de
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index a8997d7..fcb5757 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -116,6 +116,8 @@
 #define MODULES_END		(END_MEM)
 #define MODULES_VADDR		(PHYS_OFFSET)
 
+#define XIP_VIRT_ADDR(physaddr)  (physaddr)
+
 #endif /* !CONFIG_MMU */
 
 /*
-- 
1.7.8.3
