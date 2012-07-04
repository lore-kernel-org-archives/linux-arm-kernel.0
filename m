From: Barry.Song@csr.com (Barry Song)
Date: Wed, 4 Jul 2012 11:43:20 +0800
Subject: [PATCH 2/2] ARM: PRIMA2: add PINMUX map for primaII UART1 and SPI0/1
In-Reply-To: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1341373400-15763-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/prima2.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
index 82f5c0d..b2bb33d 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/prima2.c
@@ -33,6 +33,13 @@ struct of_dev_auxdata prima2_auxdata_lookup[] __initdata = {
 	{},
 };
 
+/* Padmux settings */
+static struct pinctrl_map prima2_padmux_map[] = {
+       PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl0", NULL, "uart1"),
+       PIN_MAP_MUX_GROUP_DEFAULT("spi0", "pinctrl0", NULL, "spi0"),
+       PIN_MAP_MUX_GROUP_DEFAULT("spi1", "pinctrl0", NULL, "spi1"),
+};
+
 static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{},
@@ -41,6 +48,7 @@ static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
 void __init sirfsoc_mach_init(void)
 {
 	of_platform_populate(NULL, sirfsoc_of_bus_ids, prima2_auxdata_lookup, NULL);
+	pinctrl_register_mappings(prima2_padmux_map, ARRAY_SIZE(prima2_padmux_map));
 }
 
 void __init sirfsoc_init_late(void)
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
