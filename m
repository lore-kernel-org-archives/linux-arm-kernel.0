From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:46 +0800
Subject: [PATCH 0/6] ARM: sun8i: a83t: Enable SPDIF output support
Message-ID: <20170522062552.19026-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series, apart from some minor fixes, adds SPDIF output support
with existing drivers.

The SPDIF transmitter block is the same as the one found on the H3.
There is no receiver support. The A83T pinctrl and DMA engine drivers
are already in the kernel.

Patches 1 & 2 fix some overlooked errors in the A83T's new clk driver.

Patch 3 fixes the name for the SPDIF pin function. We want to use
well known standard names. (In addition, I found some of our drivers
are using "s_twi" instead of "s_i2c". I will send fixes later.)

Patch 4 adds a device node for the DMA controller.

Patch 5 adds a device node and pinmux node for the SPDIF transmitter.

Patch 6 enables SPDIF output on the Cubietruck Plus.

Regards
ChenYu

Chen-Yu Tsai (6):
  clk: sunxi-ng: a83t: Fix PLL lock status register offset
  clk: sunxi-ng: a83t: Fix audio PLL divider offset
  pinctrl: sunxi: Fix SPDIF function name for A83T
  ARM: sun8i: a83t: Add device node for DMA controller
  ARM: sun8i: a83t: Add device node for SPDIF transmitter
  ARM: sun8i: a83t: cubietruck-plus: Enable SPDIF output

 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 22 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                | 30 ++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c            |  4 ++--
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c       |  2 +-
 4 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.11.0
