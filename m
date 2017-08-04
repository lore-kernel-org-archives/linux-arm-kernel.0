From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Aug 2017 13:47:37 +0900
Subject: [PATCH] pinctrl: sirf: add static to local data
Message-ID: <1501822057-22628-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detected by sparse.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/sirf/pinctrl-atlas7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 1efa315a7dbe..b3de1eb04ec1 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -549,7 +549,7 @@ static const struct pinctrl_pin_desc atlas7_ioc_pads[] = {
 	PINCTRL_PIN(163, "jtag_trstn"),
 };
 
-struct atlas7_pad_config atlas7_ioc_pad_confs[] = {
+static struct atlas7_pad_config atlas7_ioc_pad_confs[] = {
 	/* The Configuration of IOC_RTC Pads */
 	PADCONF(0, 3, 0x0, 0x100, 0x200, -1, 0, 0, 0, 0),
 	PADCONF(1, 3, 0x0, 0x100, 0x200, -1, 4, 2, 2, 0),
@@ -1002,7 +1002,7 @@ static const unsigned int vi_vip1_high8bit_pins[] = { 82, 83, 84, 103, 104,
 		105, 106, 107, 102, 97, 98, };
 
 /* definition of pin group table */
-struct atlas7_pin_group altas7_pin_groups[] = {
+static struct atlas7_pin_group altas7_pin_groups[] = {
 	GROUP("gnss_gpio_grp", gnss_gpio_pins),
 	GROUP("lcd_vip_gpio_grp", lcd_vip_gpio_pins),
 	GROUP("sdio_i2s_gpio_grp", sdio_i2s_gpio_pins),
@@ -4764,7 +4764,7 @@ static struct atlas7_pmx_func atlas7_pmx_functions[] = {
 			&vi_vip1_high8bit_grp_mux),
 };
 
-struct atlas7_pinctrl_data atlas7_ioc_data = {
+static struct atlas7_pinctrl_data atlas7_ioc_data = {
 	.pads = (struct pinctrl_pin_desc *)atlas7_ioc_pads,
 	.pads_cnt = ARRAY_SIZE(atlas7_ioc_pads),
 	.grps = (struct atlas7_pin_group *)altas7_pin_groups,
-- 
2.7.4
