From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Mon, 25 Oct 2010 12:55:14 -0200
Subject: [PATCH 3/4] mx31_3ds: Fix spi registration
Message-ID: <AANLkTi=kv7s8StZKEWitrBCdcuKE0qDMBUuAYkTNvAWi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit (06606ff13) "ARM: imx: dynamically register spi_imx devices
(imx31)" registered the wrong SPI port for mx31_3ds board.
mx31_3ds uses SPI2 to connect to the MC13783 PMIC.

 Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
 Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

---
 arch/arm/mach-mx3/mach-mx31_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 005c0b2..9c23146 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -242,7 +242,7 @@ static void __init mxc_board_init(void)
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);

-	imx31_add_spi_imx0(&spi1_pdata);
+	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));

-- 
1.7.0.4
