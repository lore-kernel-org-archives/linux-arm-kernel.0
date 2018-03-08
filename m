From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  8 Mar 2018 18:21:50 +0800
Subject: [PATCH v3 0/4] Set name of regmap_config
Message-ID: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v3:
Modify commit message.

Jeffy Chen (4):
  mfd: syscon: Set name of regmap_config
  rtc: at91sam9: Pass pdev->dev to regmap_init_mmio()
  clk: lpc32xx: Set name of regmap_config
  ARM: rockchip: Set name of regmap_config

 arch/arm/mach-rockchip/platsmp.c | 1 +
 drivers/clk/nxp/clk-lpc32xx.c    | 1 +
 drivers/mfd/syscon.c             | 1 +
 drivers/rtc/rtc-at91sam9.c       | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.0
