From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:55 +0900
Subject: [PATCH 07/11] ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm
 domain support
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <77192e1e25a57a519df30015b29c046bd6a769fc.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A4MP power domain, and hook up the HDMI-Link and FSI
hardware blocks.
This domain also contains the SPU2, FMSI, and BBIF2 hardware blocks,
but these are currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 ++
 arch/arm/mach-shmobile/pm-r8a7740.c            | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 0aa5bbd..e064443 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,6 +1234,8 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A4MP", &hdmi_device },
+		{ "A4MP", &fsi_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 932c2a6..081a4f9 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4LC",
 		.bit_shift	= 1,
 	}, {
+		.genpd.name	= "A4MP",
+		.bit_shift	= 2,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
2.1.1
