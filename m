From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:50 +0900
Subject: [PATCH 02/11] ARM: shmobile: r8a7740: Add missing A4S pm domain
 devices
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <3b358cb8b7c73304ea2c634afc644cfad37adbdc.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
support") added the A4S power domain, but forgot to hook up the INTCA
hardware block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 6992d40..dbf8a93 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -746,6 +746,10 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 void __init r8a7740_add_standard_devices(void)
 {
 	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4S",  &irqpin0_device },
+		{ "A4S",  &irqpin1_device },
+		{ "A4S",  &irqpin2_device },
+		{ "A4S",  &irqpin3_device },
 		{ "A3SP", &scif0_device },
 		{ "A3SP", &scif1_device },
 		{ "A3SP", &scif2_device },
-- 
2.1.1
