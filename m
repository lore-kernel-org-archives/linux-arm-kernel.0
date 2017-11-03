From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 4 Nov 2017 02:17:03 +0800
Subject: [PATCH] clk: meson: gxbb: fix wrong clock for SARADC
Message-ID: <20171103181703.30434-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, the clock gate bit for
SARADC is bit[22] in Meson-GXBB/GXL series.

Change-Id: Ic4fa58276d2a9ea273eef0a08541fc213ac5ac89
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index b2d1e8ed7152..4f5b535fcd12 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1139,7 +1139,6 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -1149,6 +1148,7 @@ static MESON_GATE(gxbb_async_fifo, HHI_GCLK_MPEG0, 16);
 static MESON_GATE(gxbb_sdio, HHI_GCLK_MPEG0, 17);
 static MESON_GATE(gxbb_abuf, HHI_GCLK_MPEG0, 18);
 static MESON_GATE(gxbb_hiu_iface, HHI_GCLK_MPEG0, 19);
+static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 22);
 static MESON_GATE(gxbb_assist_misc, HHI_GCLK_MPEG0, 23);
 static MESON_GATE(gxbb_emmc_a, HHI_GCLK_MPEG0, 24);
 static MESON_GATE(gxbb_emmc_b, HHI_GCLK_MPEG0, 25);
-- 
2.14.1
