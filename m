From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 19 Nov 2014 11:06:03 +0800
Subject: [PATCH 0/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
Message-ID: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference to Chapter 3 Clock & Reset Unit (CRU) of RK3288 TRM, i2s0_clkout has
two source clock, XIN24M_DIV2 for 12M and clk_i2s0 for more kinds of
frequencies, I2S0(i2s_clk) has only single source clock clk_i2s0.

i2s0_clkout: generate to output to outside of chip, generally for codec
I2S0(i2s_clk): generate for i2s controller inside of chip

Jianqun Xu (2):
  ASoC: rockchip-i2s: dt: add i2s_clkout to list of clocks
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt |  5 +++--
 sound/soc/rockchip/rockchip_i2s.c                        | 11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.9.1
