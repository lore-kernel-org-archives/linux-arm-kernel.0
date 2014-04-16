From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Apr 2014 08:42:13 -0500
Subject: [PATCH] ARM: fix missing CLKSRC_OF on multi-platform
Message-ID: <1397655733-15514-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

In commit ddb902cc34593e (ARM: centralize common multi-platform kconfig
options), CLKSRC_OF was removed from some platforms, but not added to
ARCH_MULTIPLATFORM. Fix this.

Reported-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Arnd, Kevin, Olof,

Please apply this rather than the various patches fixing single 
platforms. Really, CLKSRC_OF should be selected in each timer config 
option, but this is a much more simple fix.

Rob

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb..a48712e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -311,6 +311,7 @@ config ARCH_MULTIPLATFORM
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
+	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
-- 
1.9.1
