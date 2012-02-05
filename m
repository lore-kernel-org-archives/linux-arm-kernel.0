From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  5 Feb 2012 13:39:40 +0200
Subject: [PATCH] arm: omap3: cm-t35: fix section mismatch warning
In-Reply-To: <20120205012556.GG1426@atomide.com>
References: <20120205012556.GG1426@atomide.com>
Message-ID: <1328441980-28892-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xeae8):
Section mismatch in reference from the function cm_t35_init_usbh()
to the (unknown reference) .init.data:(unknown)
The function cm_t35_init_usbh() references
the (unknown reference) __initdata (unknown).
This is often because cm_t35_init_usbh lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
Sorry about this one. I fixed similar problem for cm-t3517 a while ago,
but somehow missed cm-t35. Thanks for spotting.
Probably enabling the CONFIG_DEBUG_SECTION_MISMATCH in defconfigs
can raise people awareness for this.

 arch/arm/mach-omap2/board-cm-t35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d839c05..a8cedbe 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -436,7 +436,7 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static void cm_t35_init_usbh(void)
+static void  __init cm_t35_init_usbh(void)
 {
 	int err;
 
-- 
1.7.3.4
