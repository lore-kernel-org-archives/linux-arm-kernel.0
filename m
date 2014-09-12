From: cernekee@gmail.com (Kevin Cernekee)
Date: Thu, 11 Sep 2014 19:22:42 -0700
Subject: [PATCH 3/3] ARM: Allow either FLATMEM or SPARSEMEM on the multi-v7
 build
In-Reply-To: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
Message-ID: <1410488562-21863-3-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 chips with LPAE can often benefit from SPARSEMEM, as portions of
system memory can be located deep in the 36-bit address space.  Allow
FLATMEM or SPARSEMEM to be selectable at compile time; FLATMEM remains
the default.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/arm/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c3daeaf..db7614e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -821,6 +821,8 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
+	select ARCH_FLATMEM_ENABLE
+	select ARCH_SPARSEMEM_ENABLE
 	select CPU_V7
 	select HAVE_SMP
 
@@ -1632,6 +1634,9 @@ config OABI_COMPAT
 config ARCH_HAS_HOLES_MEMORYMODEL
 	bool
 
+config ARCH_FLATMEM_ENABLE
+	bool
+
 config ARCH_SPARSEMEM_ENABLE
 	bool
 
-- 
1.7.9.5
