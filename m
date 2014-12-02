From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Tue,  2 Dec 2014 23:08:40 +0100
Subject: [PATCH] arch: arm: mach-davinci: serial.c: Cleaning up function that
 are not used anywhere
Message-ID: <1417558120-26540-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove function serial_read_reg() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-davinci/serial.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 5e93a73..951b620 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -31,16 +31,6 @@
 #include <mach/serial.h>
 #include <mach/cputype.h>
 
-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
-					   int offset)
-{
-	offset <<= up->regshift;
-
-	WARN_ONCE(!up->membase, "unmapped read: uart[%d]\n", offset);
-
-	return (unsigned int)__raw_readl(up->membase + offset);
-}
-
 static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 				    int value)
 {
-- 
1.7.10.4
