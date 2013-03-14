From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Mar 2013 15:19:39 +0800
Subject: [PATCH v4 0/5] support hisilicon SoC
Message-ID: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v4:
   1. Discard sp804 since Rob's patch also handle this.
   2. Update pinmux setting in DTS.
   3. Update sp804 setting in DTS.
v3:
   1. Replace to call hs_init_clocks() in hi3xxx.c by of_clk_init().
   2. Add CLK_OF_DECLARE() in clk-hi3xxx driver.
   3. Add "select USE_OF" for CONFIG_CLKSRC_OF configuration. So drop CONFIG_OF in sp804 driver.
   4. Move readme file into driver patch.
   5. Append "arm,integrator-timer" for sp804 match table.
v2:
   1. Rename mach-hs to mach-hi3xxx.
   2. Remove CONFIG_MACH_HS_DT.
   3. Move sp804 dual timer driver into drivers/clocksource.
   4. Make sp804 driver to support DT. Append CLOCKSOURCE_OF_DECLARE() in sp804 driver.
   5. Update hisilicon,hi3620-clkgate & hisilicon,hi3620-clkrst property in clk-hi3xxx driver.
