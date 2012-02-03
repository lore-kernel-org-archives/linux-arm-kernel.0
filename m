From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:36:52 +0000
Subject: [PATCH 17/17] ARM: sa11x0: neponset: don't static map neponset
 registers
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOwG-0001Ce-RI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we ioremap() the neponset register space, there's no need
to static map the neponset registers.  Get rid of this static mapping.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 3c0d4b8..7ffa631 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -434,12 +434,7 @@ static int __init neponset_init(void)
 subsys_initcall(neponset_init);
 
 static struct map_desc neponset_io_desc[] __initdata = {
-	{	/* System Registers */
-		.virtual	=  0xf3000000,
-		.pfn		= __phys_to_pfn(0x10000000),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE
-	}, {	/* SA-1111 */
+	{	/* SA-1111 */
 		.virtual	=  0xf4000000,
 		.pfn		= __phys_to_pfn(0x40000000),
 		.length		= SZ_1M,
-- 
1.7.4.4
