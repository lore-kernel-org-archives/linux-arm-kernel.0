From: qy03fugy@stud.informatik.uni-erlangen.de (Christian Dietrich)
Date: Mon, 6 Sep 2010 16:35:54 +0200
Subject: [PATCH 01/14] arch/arm: Removing undead ifdef __ASSEMBLY__
In-Reply-To: <cover.1283782698.git.qy03fugy@stud.informatik.uni-erlangen.de>
References: <cover.1283782698.git.qy03fugy@stud.informatik.uni-erlangen.de>
Message-ID: <e09809579db119258c1cd1c7dd9bd95859aa9894.1283782700.git.qy03fugy@stud.informatik.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __ASSEMBLY__ ifdef isn't necessary at this point, because it is
checked in an outer ifdef level already and has no effect here.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
---
 arch/arm/mach-ixp23xx/include/mach/platform.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/include/mach/platform.h b/arch/arm/mach-ixp23xx/include/mach/platform.h
index db9d941..9f05ea4 100644
--- a/arch/arm/mach-ixp23xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp23xx/include/mach/platform.h
@@ -43,7 +43,6 @@ extern struct sys_timer ixp23xx_timer;
 
 #define IXP23XX_UART_XTAL		14745600
 
-#ifndef __ASSEMBLY__
 /*
  * Is system memory on the XSI or CPP bus?
  */
@@ -51,7 +50,5 @@ static inline unsigned ixp23xx_cpp_boot(void)
 {
 	return (*IXP23XX_EXP_CFG0 & IXP23XX_EXP_CFG0_XSI_NOT_PRES);
 }
-#endif
-
 
 #endif
-- 
1.7.0.4
