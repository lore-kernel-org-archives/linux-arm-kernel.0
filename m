From: r.sricharan@ti.com (R Sricharan)
Date: Wed, 12 Sep 2012 11:20:06 +0530
Subject: [RFC PATCH] ARM: mm: ADD descriptor string to CONFIG_DMA_ADDR_64BIT_T
Message-ID: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
the feature is not getting selected.
Adding a string description in the Kconfig resolves this.

But not sure if this is the right way to fix this.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 101b968..90c5ea4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -601,7 +601,7 @@ config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
 config ARCH_DMA_ADDR_T_64BIT
-	bool
+	bool "64bit capable DMA device"
 
 config ARM_THUMB
 	bool "Support Thumb user binaries"
-- 
1.7.9.5
