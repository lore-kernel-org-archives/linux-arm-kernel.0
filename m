From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  8 Jul 2014 18:21:11 +0200
Subject: [PATCHv2 1/6] ARM: at91: Add new binding for sama5d3-ddramc
In-Reply-To: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404836476-23787-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IP for the SDRAM controller found on sama5d3 SoCs is different from the g45
one. Introduce a new compatible string to reflect that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 1 +
 arch/arm/mach-at91/setup.c                           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 16f60b41c147..54dc3aefb12a 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -61,6 +61,7 @@ RAMC SDRAM/DDR Controller required properties:
 - compatible: Should be "atmel,at91rm9200-sdramc",
 			"atmel,at91sam9260-sdramc",
 			"atmel,at91sam9g45-ddramc",
+			"atmel,sama5d3-ddramc",
 - reg: Should contain registers location and length
   For at91sam9263 and at91sam9g45 you must specify 2 entries.
 
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index f7a07a58ebb6..faff1eae3e65 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -384,6 +384,7 @@ static struct of_device_id ramc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
+	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
 	{ /*sentinel*/ }
 };
 
-- 
1.9.1
