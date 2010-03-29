From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Mar 2010 14:24:51 +0100
Subject: [PATCH] ARM: Fix the __arm_ioremap_caller() definition in nommu.c
Message-ID: <20100329132450.1967.70117.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 31aa8fd6 introduced the __arm_ioremap_caller() function but the
nommu.c version did not have the _caller suffix.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/nommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 9bfeb6b..f8791ee 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -87,8 +87,8 @@ void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
-void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
-			    unsigned int mtype, void *caller)
+void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
+				   unsigned int mtype, void *caller)
 {
 	return __arm_ioremap(phys_addr, size, mtype);
 }
