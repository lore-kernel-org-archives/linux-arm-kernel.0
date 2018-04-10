From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 Apr 2018 14:51:36 +0200
Subject: [PATCH v2 0/5] Use of_clk_get_parent_count() instead of open coding
Message-ID: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Mike, Stephen, et al,

This patch series replaces open-coded versions of
of_clk_get_parent_count() by calls to the helper function.

Changes compared to v1:
  - Move OF clock helpers (a.o. of_clk_get_parent_count()) to their own
    include file <linux/of_clk.h>, as suggested by Stephen,
  - Update includes for the above change,
  - Fix timer-sp804, now a dummy is available in the !CONFIG_COMMON_CLK
    case,
  - Fix a new occurrence.

Note that patches 2-5 depend on the first patch.  To simplify
dependencies, perhaps the first patch can still make it in v4.17-rc1?

Thanks!

Geert Uytterhoeven (5):
  clk: Extract OF clock helpers in <linux/of_clk.h>
  ARM: timer-sp: Use of_clk_get_parent_count() instead of open coding
  soc: rockchip: power-domain: Use of_clk_get_parent_count() instead of
    open coding
  soc/tegra: pmc: Use of_clk_get_parent_count() instead of open coding
  pinctrl: sunxi: Use of_clk_get_parent_count() instead of open coding

 drivers/clocksource/timer-sp804.c     |  3 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |  4 ++--
 drivers/soc/rockchip/pm_domains.c     |  4 ++--
 drivers/soc/tegra/pmc.c               |  3 ++-
 include/linux/clk-provider.h          | 14 +-------------
 include/linux/of_clk.h                | 29 +++++++++++++++++++++++++++++
 6 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/of_clk.h

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
