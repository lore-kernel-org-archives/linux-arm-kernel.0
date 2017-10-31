From: james.morse@arm.com (James Morse)
Date: Tue, 31 Oct 2017 15:38:28 +0000
Subject: [RFC/RFT PATCH 2/6] x86/mm/fixmap: Add GHES fixmap entries
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <20171031153832.17746-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GHES is switching to use fixmap for its dynamic mapping of CPER records,
to avoid using ioremap_page_range() in IRQ/NMI context.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/fixmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index dcd9fb55e679..be3cc32db7f0 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -104,6 +104,10 @@ enum fixed_addresses {
 	FIX_GDT_REMAP_BEGIN,
 	FIX_GDT_REMAP_END = FIX_GDT_REMAP_BEGIN + NR_CPUS - 1,
 
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+	FIX_APEI_GHES_NMI,
+
 	__end_of_permanent_fixed_addresses,
 
 	/*
-- 
2.15.0.rc2
