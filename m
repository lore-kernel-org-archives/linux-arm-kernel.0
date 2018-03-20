From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 20 Mar 2018 13:03:29 -0300
Subject: [PATCH 0/3] Fix audio regression on rk3288
Message-ID: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Currently on rk3288 boards the ASoC machine driver fails to load,
breaking audio support.

Apparently, the regression was introduced by commit 24069b589b02
("ASoC: hdmi-codec: remove multi detection support") which changed
the codec name.

If there is a lesson here, it would be about binding drivers using
strings and how fragile this is. Or maybe it's about regression
testing. Or maybe there isn't a lesson.

Anyway, the first patch fixes the regression; the second patch
makes the machine driver selects all the codecs it; finally
the third patch is just a binding documentation fix.

Tested on a Radxa Rock2 Square board.

Ezequiel Garcia (3):
  ASoC: rockchip: Fix dai_name for HDMI codec
  ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
  dt-bindings: sound: rockchip Fix compatible string in example

 .../devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt          | 2 +-
 sound/soc/rockchip/Kconfig                                             | 3 +++
 sound/soc/rockchip/rk3288_hdmi_analog.c                                | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.16.2
