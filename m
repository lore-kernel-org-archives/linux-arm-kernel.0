From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon,  2 Jan 2017 11:18:02 +0100
Subject: [PATCH] ARM: imx: Add rtc support to i.MX31 PDK board.
Message-ID: <1483352282-28970-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for i.MX31 RTC on the PDK board.

Tested on actual hardware.

Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 12b8a52..c6a12ac 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -710,6 +710,7 @@ static void __init mx31_3ds_init(void)
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	imx31_add_imx2_wdt();
+	imx31_add_mxc_rtc();
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 
 	imx31_add_spi_imx0(&spi0_pdata);
-- 
2.7.4
