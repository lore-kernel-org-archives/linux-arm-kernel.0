From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Mar 2011 21:30:58 +0100
Subject: [PATCH 1/2] ARM: mx3/cpuimx35: fix build failure
In-Reply-To: <20110301203018.GY22310@pengutronix.de>
References: <20110301203018.GY22310@pengutronix.de>
Message-ID: <1299011459-18200-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems vim's autocompletion played tricks on me without me noticing.
This was intruduced in
	97976e2 (ARM: mx3: use .init_early to initialize cpu type, reset address and iomuxer)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-cpuimx35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index a42f1a9..ec63d99 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -196,7 +196,7 @@ MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
 	/* Maintainer: Eukrea Electromatique */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
 	.map_io = mx35_map_io,
-	.init_ext3_fs = imx35_init_early,
+	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
 	.timer = &eukrea_cpuimx35_timer,
 	.init_machine = eukrea_cpuimx35_init,
-- 
1.7.2.3
