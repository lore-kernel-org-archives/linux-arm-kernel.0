From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed,  3 Dec 2014 15:18:36 +0800
Subject: [PATCH v2 0/2] ASoC: rockchip: i2s: driver could output "i2s-clk-out"
 optionally
In-Reply-To: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock generate unit in rockchip SoCs could generate clock named "i2s-clk-out"
separate from clock named "i2s-hclk", which is for i2s controller.

Since there may not need the "i2s-clk-out" outside, we make it optional in
driver, that could be decided in dts by add "i2s-clk-out" or not.

Tested on devices based on rk3288 with max98090 codec.

Jianqun Xu (1):
  ASoC: dt-bindings: rockchip-i2s: add an optional property
    "i2s_clk_out"

Sonny Rao (1):
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt |  8 ++++++--
 sound/soc/rockchip/rockchip_i2s.c                        | 13 +++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--
changes since v1:
- rework with patches commit message, reference to old commit message of the
same related files.
- generate patch again by apply sonny's patch
- fix blank line in driver, suggested by Heiko and Doug, so add my owner
singed-off-by

1.9.1
