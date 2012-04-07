From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  7 Apr 2012 19:30:23 +0200
Subject: [PATCH 2/2 v2] ARM: at91: Export at91_matrix_base
In-Reply-To: <1333819823-2279-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333819823-2279-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <1333819823-2279-2-git-send-email-joachim.eastwood@jotron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_matrix_* macro's are used by at91_udc usb gadget driver,
which can be built as module, therefore we need to export the
variable containing matrix base address.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---

Now exported as GPL only symbol.

 arch/arm/mach-at91/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index a1fcba3..314be7c 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -293,6 +293,7 @@ void __init at91_ioremap_rstc(u32 base_addr)
 }
 
 void __iomem *at91_matrix_base;
+EXPORT_SYMBOL_GPL(at91_matrix_base);
 
 void __init at91_ioremap_matrix(u32 base_addr)
 {
-- 
1.7.9.6
