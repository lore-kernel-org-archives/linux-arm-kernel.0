From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 07 Oct 2011 15:28:29 +0100
Subject: [PATCH 3/5 v4] ARM Realview PCIX board file changes
In-Reply-To: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007142815.19554.44468.stgit@e102602-lin.cambridge.arm.com>
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
index b43644b..17a3340 100644
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
index 763e8f3..1ed9dd8 100644
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
index 363b0ab..1d7d191 100644
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
