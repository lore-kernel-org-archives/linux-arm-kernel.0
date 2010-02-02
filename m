From: rurality.linux@gmail.com (Qiang Wang)
Date: Tue, 2 Feb 2010 14:28:39 +0900
Subject: [PATCH]NUC900 add gpio virtual memory map
Message-ID: <71413c851002012128l26bbf64fvfffabcae194f076e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Dear Wan

   This patch adds the gpio registers virtual memory map.
   Without it, the gpio access will cause the "Data Abort" due to no
virtual memory assign to it.

Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
Cc: Wang Zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/cpu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 20dc0c9..7a79de0 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -45,6 +45,7 @@ static struct map_desc nuc900_iodesc[] __initdata = {
 	IODESC_ENT(UART),
 	IODESC_ENT(TIMER),
 	IODESC_ENT(EBI),
+	IODESC_ENT(GPIO),
 };

 /* Initial clock declarations. */
-- 
1.6.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nuc900-add-gpio-virtual-memory-map.patch
Type: application/octet-stream
Size: 558 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/f8fb9fd0/attachment.obj>
