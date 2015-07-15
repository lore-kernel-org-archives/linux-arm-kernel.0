From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 15 Jul 2015 11:15:41 +0800
Subject: [PATCH 0/2] Add codec machine driver for rockchip platform
Message-ID: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

Hi,
  The simple-card is not common at present, soc maybe need own machine
driver for jack detection.
    Add drivers for two families of rockchip-bases chromebooks.  These
machine drives don't use simplecard because we need custom jack
detection plumbing.

- use ts3a227e for ext jack detection with max98090
- call rt5645_set_jack_detect function via rt5645 codec driver

Thanks.

zhengxing (2):
  ASoC: rockchip: Add machine driver for max98090 codec
  ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

 sound/soc/rockchip/Kconfig             |   19 +++
 sound/soc/rockchip/Makefile            |    6 +
 sound/soc/rockchip/rockchip_max98090.c |  246 ++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_rt5645.c   |  235 ++++++++++++++++++++++++++++++
 4 files changed, 506 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

-- 
1.7.9.5
