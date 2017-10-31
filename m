From: james.morse@arm.com (James Morse)
Date: Tue, 31 Oct 2017 15:38:27 +0000
Subject: [RFC/RFT PATCH 1/6] arm64: fixmap: Add GHES fixmap entries
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <20171031153832.17746-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GHES is switching to use fixmap for its dynamic mapping of CPER records,
to avoid using ioremap_page_range() in IRQ/NMI context.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/fixmap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index caf86be815ba..4edcdcb01a68 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -51,6 +51,11 @@ enum fixed_addresses {
 
 	FIX_EARLYCON_MEM_BASE,
 	FIX_TEXT_POKE0,
+
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+	FIX_APEI_GHES_NMI,
+
 	__end_of_permanent_fixed_addresses,
 
 	/*
-- 
2.15.0.rc2
