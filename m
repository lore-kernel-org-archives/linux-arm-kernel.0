From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Apr 2011 01:15:53 -0600
Subject: [PATCH v5 5/8] arm/dt: Drop irq_create_of_mapping() from arm code.
In-Reply-To: <20110429070135.12522.35745.stgit@ponder>
References: <20110429070135.12522.35745.stgit@ponder>
Message-ID: <20110429071553.12522.65073.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now implemented by core code.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/kernel/devtree.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index a701e42..1e0b613 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -129,17 +129,3 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	return mdesc_best;
 }
-
-/**
- * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
- *
- * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
- * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
- * supported.
- */
-unsigned int irq_create_of_mapping(struct device_node *controller,
-				   const u32 *intspec, unsigned int intsize)
-{
-	return intspec[0];
-}
-EXPORT_SYMBOL_GPL(irq_create_of_mapping);
