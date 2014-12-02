From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Tue,  2 Dec 2014 22:49:24 +0800
Subject: [PATCH 0/2] rockchip: i2s: patches to add optional clock output from
Message-ID: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock output from rockchip SoCs' CRU to chip outside is from the same source
as hclk which is for i2s controller. We make it optional because some audio
codec outside not need the master clock from SoC but from other clock source.

Jianqun Xu (2):
  ASoC: rockchip-i2s: dt: add an optional property "i2s_clk_out"
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt |  8 ++++++--
 sound/soc/rockchip/rockchip_i2s.c                        | 11 +++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
1.9.1
