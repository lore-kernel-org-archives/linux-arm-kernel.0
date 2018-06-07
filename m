From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu,  7 Jun 2018 10:41:06 +0200
Subject: [PATCH 3/4] ARM: at91: fix USB clock detection handling
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Message-ID: <20180607084107.4461-4-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add more compatibles to be able to correct the USB clock detection.

at91sam9261 and at91sam9263 have the same PMC_SCSR layout as at91sam9260.
at91sam9rl doesn't have any USB clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 849014c01cf4..563f34d01ce4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -559,15 +559,20 @@ static const struct pmc_info pmc_infos[] __initconst = {
 	{ .uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP },
 	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP },
 	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP },
+	{ .uhp_udp_mask = 0 },
 };
 
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-pmc", .data = &pmc_infos[0] },
 	{ .compatible = "atmel,at91sam9260-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9261-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9263-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-pmc", .data = &pmc_infos[2] },
 	{ .compatible = "atmel,at91sam9n12-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9rl-pmc", .data = &pmc_infos[3] },
 	{ .compatible = "atmel,at91sam9x5-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d3-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ /* sentinel */ },
 };
-- 
2.17.1
