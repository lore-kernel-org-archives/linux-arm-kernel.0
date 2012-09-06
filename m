From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 6 Sep 2012 12:05:45 +0530
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
In-Reply-To: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
Message-ID: <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 5:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
> AUXCOREBOOT1 register contents twice.  This seems like a waste of
> time, so, remove the duplicates.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Looks fine to me. Thanks Paul.
Reviewed-by: Santosh Shilimkar ,santosh.shilimkar at ti.com>

While reviewing your patch, i noticed a typo in the code.
Since the patch fixes nearby code as the subject patch, I generated
that patch on top of yours. Same is end of the email as well as
attachment. The patch applies on top of your patch.

Regards
Santosh

>From 5fcd24e5782e502aa607b73de78be68b394f9639 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 6 Sep 2012 11:51:34 +0530
Subject: [PATCH] ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT register
 save

The wakeupgen context-save code reads AUXCOREBOOT0 register
instead of AUXCOREBOOT1 register contents while saving AUXCOREBOOT1.

Fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index b55432d..567f672 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -229,7 +229,7 @@ static inline void omap4_irq_save_context(void)
 	/* Save AuxBoot* registers */
 	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-- 
1.7.9.5
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch
Type: application/octet-stream
Size: 1192 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/e294aa02/attachment.obj>
