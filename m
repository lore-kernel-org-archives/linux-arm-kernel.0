From: PeterHuewe@gmx.de (Peter Huewe)
Date: Wed, 16 Jun 2010 19:32:00 +0200
Subject: [PATCH] arm/include: Fix missing semicolon in module.h
Message-ID: <201006161932.00542.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch fixes a missing semicolon which introduced buildfailures [2] for
almost every arm defconfig, introduced by patch cecaa4c6b [1]

This issue arises only if CONFIG_ARM_UNWIND is not set.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100616
References:
[1] cecaa4c6b ARM: 6172/1: module - additional unwind tables for exit/devexit
[2] http://kisskb.ellerman.id.au/kisskb/compiler/11/
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/2725882/

 arch/arm/include/asm/module.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index fcff0d2..cbb0bc2 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -26,7 +26,7 @@ struct mod_arch_specific {
 };
 #else
 struct mod_arch_specific {
-}
+};
 #endif
 
 /*
-- 
1.6.4.4
