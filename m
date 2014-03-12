From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Mar 2014 15:35:47 -0600
Subject: [PATCH] pinctrl: tegra: fix some mistakes in Tegra124
Message-ID: <1394660147-9927-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A couple of pairs of pin group names were swapped in the table. This
caused the wrong register to be programmed. Luckily, this had little
effect, if any, since the swapped pins were likely to be programmed
identically.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra124.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra124.c b/drivers/pinctrl/pinctrl-tegra124.c
index d1ec687ddfff..73773706755b 100644
--- a/drivers/pinctrl/pinctrl-tegra124.c
+++ b/drivers/pinctrl/pinctrl-tegra124.c
@@ -1,7 +1,7 @@
 /*
  * Pinctrl data for the NVIDIA Tegra124 pinmux
  *
- * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1804,8 +1804,8 @@ static const struct tegra_pingroup tegra124_groups[] = {
        PINGROUP(pu4,                    PWM1,       UARTA,      GMI,          DISPLAYB,    PWM1,       0x3194,  N,  N,  N),
        PINGROUP(pu5,                    PWM2,       UARTA,      GMI,          DISPLAYB,    PWM2,       0x3198,  N,  N,  N),
        PINGROUP(pu6,                    PWM3,       UARTA,      RSVD3,        GMI,         RSVD3,      0x319c,  N,  N,  N),
-       PINGROUP(gen1_i2c_scl_pc4,       I2C1,       RSVD2,      RSVD3,        RSVD4,       I2C1,       0x31a0,  Y,  N,  N),
-       PINGROUP(gen1_i2c_sda_pc5,       I2C1,       RSVD2,      RSVD3,        RSVD4,       I2C1,       0x31a4,  Y,  N,  N),
+       PINGROUP(gen1_i2c_sda_pc5,       I2C1,       RSVD2,      RSVD3,        RSVD4,       I2C1,       0x31a0,  Y,  N,  N),
+       PINGROUP(gen1_i2c_scl_pc4,       I2C1,       RSVD2,      RSVD3,        RSVD4,       I2C1,       0x31a4,  Y,  N,  N),
        PINGROUP(dap4_fs_pp4,            I2S3,       GMI,        DTV,          RSVD4,       I2S3,       0x31a8,  N,  N,  N),
        PINGROUP(dap4_din_pp5,           I2S3,       GMI,        RSVD3,        RSVD4,       I2S3,       0x31ac,  N,  N,  N),
        PINGROUP(dap4_dout_pp6,          I2S3,       GMI,        DTV,          RSVD4,       I2S3,       0x31b0,  N,  N,  N),
@@ -1942,8 +1942,8 @@ static const struct tegra_pingroup tegra124_groups[] = {
        PINGROUP(gpio_w3_aud_pw3,        SPI6,       SPI1,       SPI2,         I2C1,        SPI1,       0x33f0,  N,  N,  N),
        PINGROUP(usb_vbus_en0_pn4,       USB,        RSVD2,      RSVD3,        RSVD4,       USB,        0x33f4,  Y,  N,  N),
        PINGROUP(usb_vbus_en1_pn5,       USB,        RSVD2,      RSVD3,        RSVD4,       USB,        0x33f8,  Y,  N,  N),
-       PINGROUP(sdmmc3_clk_lb_out_pee4, SDMMC3,     RSVD2,      RSVD3,        RSVD4,       SDMMC3,     0x33fc,  N,  N,  N),
-       PINGROUP(sdmmc3_clk_lb_in_pee5,  SDMMC3,     RSVD2,      RSVD3,        RSVD4,       SDMMC3,     0x3400,  N,  N,  N),
+       PINGROUP(sdmmc3_clk_lb_in_pee5,  SDMMC3,     RSVD2,      RSVD3,        RSVD4,       SDMMC3,     0x33fc,  N,  N,  N),
+       PINGROUP(sdmmc3_clk_lb_out_pee4, SDMMC3,     RSVD2,      RSVD3,        RSVD4,       SDMMC3,     0x3400,  N,  N,  N),
        PINGROUP(gmi_clk_lb,             SDMMC2,     RSVD2,      GMI,          RSVD4,       SDMMC2,     0x3404,  N,  N,  N),
        PINGROUP(reset_out_n,            RSVD1,      RSVD2,      RSVD3,        RESET_OUT_N, RSVD1,      0x3408,  N,  N,  N),
        PINGROUP(kb_row16_pt0,           KBC,        RSVD2,      RSVD3,        UARTC,       KBC,        0x340c,  N,  N,  N),
-- 
1.8.1.5
