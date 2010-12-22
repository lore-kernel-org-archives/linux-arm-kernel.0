From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 22 Dec 2010 14:04:20 +0000
Subject: [PATCH 5/6] ARM Realview PCIX board file changes
In-Reply-To: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101222140420.29725.74165.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PCI support to the board files
for the Realview Northbridge boards.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/mach-realview/realview_pb11mp.c |   18 ++++++++++++++++++
 arch/arm/mach-realview/realview_pba8.c   |   18 ++++++++++++++----
 arch/arm/mach-realview/realview_pbx.c    |   16 +++++++++++++---
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 117b95b..8acb76b 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -95,6 +95,24 @@ static struct map_desc realview_pb11mp_io_desc[] __initdata = {
 		.length		= SZ_8K,
 		.type		= MT_DEVICE,
 	},
+#ifdef CONFIG_PCI
+	{
+		.virtual	= (unsigned long)PCIX_UNIT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= (unsigned long)REALVIEW_PCI_IO_VBASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_IO_BASE),
+		.length		= REALVIEW_PB_PCI_IO_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual        = IO_ADDRESS(REALVIEW_ISSP_REG_BASE),
+		.pfn            = __phys_to_pfn(REALVIEW_ISSP_REG_BASE),
+		.length         = SZ_4K,
+		.type           = MT_DEVICE,
+	},
+#endif
 #ifdef CONFIG_DEBUG_LL
 	{
 		.virtual	= IO_ADDRESS(REALVIEW_PB11MP_UART0_BASE),
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 929b8dc..e7f4c36 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -79,10 +79,20 @@ static struct map_desc realview_pba8_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_PCI
 	{
-		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBA8_PCI_BASE),
-		.length		= REALVIEW_PBA8_PCI_BASE_SIZE,
-		.type		= MT_DEVICE
+		.virtual	= (unsigned long)PCIX_UNIT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= (unsigned long)REALVIEW_PCI_IO_VBASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_IO_BASE),
+		.length		= REALVIEW_PB_PCI_IO_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(REALVIEW_ISSP_REG_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_ISSP_REG_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	},
 #endif
 #ifdef CONFIG_DEBUG_LL
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index b9f9e20..42fc304 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -80,9 +80,19 @@ static struct map_desc realview_pbx_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_PCI
 	{
-		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBX_PCI_BASE),
-		.length		= REALVIEW_PBX_PCI_BASE_SIZE,
+		.virtual	= (unsigned long)PCIX_UNIT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= (unsigned long)REALVIEW_PCI_IO_VBASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_IO_BASE),
+		.length		= REALVIEW_PB_PCI_IO_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(REALVIEW_ISSP_REG_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_ISSP_REG_BASE),
+		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	},
 #endif
