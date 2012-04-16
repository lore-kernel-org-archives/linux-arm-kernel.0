From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:48 +0200
Subject: [PATCH 04/12] ARM: at91: Export at91_matrix_base
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <ac8c411c8360c281d1fb5e03a975e9088d069ded.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

at91_matrix_* macro's are used by at91_udc usb gadget driver,
which can be built as module, therefore we need to export the
variable containing matrix base address.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 0607847..f44a2e7 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -293,6 +293,7 @@ void __init at91_ioremap_rstc(u32 base_addr)
 }
 
 void __iomem *at91_matrix_base;
+EXPORT_SYMBOL_GPL(at91_matrix_base);
 
 void __init at91_ioremap_matrix(u32 base_addr)
 {
-- 
1.7.10
