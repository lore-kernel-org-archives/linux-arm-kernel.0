From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 20 Oct 2010 14:03:16 +0100
Subject: [PATCH 5/6] ARM Realview PCIX board file changes
In-Reply-To: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101020130316.22199.85765.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PCI support to the board files
for the Realview Northbridge boards.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/mach-realview/realview_pb11mp.c |   18 ++++++++++++++++++
 arch/arm/mach-realview/realview_pba8.c   |   16 +++++++++++++---
 arch/arm/mach-realview/realview_pbx.c    |   14 ++++++++++++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index d591bc0..c84bda6 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -95,6 +95,24 @@ static struct map_desc realview_pb11mp_io_desc[] __initdata = {
 		.length		= SZ_8K,
 		.type		= MT_DEVICE,
 	},
+#ifdef CONFIG_PCI
+	{
+		.virtual	= PCIX_UNIT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= REALVIEW_PCI_IO_VBASE,
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
index 6c37621..09bcd46 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -80,9 +80,19 @@ static struct map_desc realview_pba8_io_desc[] __initdata = {
 #ifdef CONFIG_PCI
 	{
 		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBA8_PCI_BASE),
-		.length		= REALVIEW_PBA8_PCI_BASE_SIZE,
-		.type		= MT_DEVICE
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= REALVIEW_PCI_IO_VBASE,
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
index 9428eff..5cd0a9a 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -81,8 +81,18 @@ static struct map_desc realview_pbx_io_desc[] __initdata = {
 #ifdef CONFIG_PCI
 	{
 		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBX_PCI_BASE),
-		.length		= REALVIEW_PBX_PCI_BASE_SIZE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB_PCI_BASE),
+		.length		= REALVIEW_PB_PCI_BASE_SIZE,
+		.type		= MT_DEVICE,
+	 }, {
+		.virtual	= REALVIEW_PCI_IO_VBASE,
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
