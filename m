From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:15 +0000
Subject: [PATCH 16/19] ARM: sa1100: don't warn about mach/ide.h
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This warning has existed since before the start of (git) history.
Apparently nobody has bothered to fix it in a long time, and
this is unlikely to change. Note that the file that the warning
refers to has moved to a different location and was subsequently
deleted in 2008.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/lart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index f69f78f..bca7e60 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -24,9 +24,6 @@
 
 #include "generic.h"
 
-
-#warning "include/asm/arch-sa1100/ide.h needs fixing for lart"
-
 static struct mcp_plat_data lart_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
-- 
1.8.0
