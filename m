From: acgzxing@gmail.com (Xing Zheng)
Date: Tue, 12 May 2015 17:26:33 +0800
Subject: [PATCH 0/4] ASoC: rockchip: add rockchip machine driver
Message-ID: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>


Hi,

These patches to add machine driver for rockchip platform.

We intended to use simple-card on the project, but it seem like that have
some issues(jack detection). We need the following features on the project,
but simple-card is temporarily unable to provide them:
1. We need dynamically recognize and select one codec from supported codecs
   in dts.
2. Simple-card don't provide to call the codec jack detection callback via dts
   description (ts3a227e_enable_jack_detect for max98090, rt5645_set_jack_detect
   for rt5645/rt5650).
3. Simple-card support simple-widght only, but codec may use cunstom the name of
   widget (rk_dapm_widgets: "Headset Mic", "Int Mic" in max98090).

Simple-card is good generic machine driver, but if we want to replace simple-card
in the exsiting work, it may bring other problems. Therefore, we want to upload
these functions that we need.



zhengxing (4):
  ASoC: rockchip: add rockchip machine driver
  ASoC: rockchip: add rockchip machine driver for max98090
  ASoC: rockchip: add rockchip machine driver for rt5650/rt5645
  ASoC: rockchip-audio-machine: add rockchip machine driver bindings

 .../sound/rockchip,rockchip-audio-machine.txt      |   38 ++++
 sound/soc/rockchip/Kconfig                         |   26 +++
 sound/soc/rockchip/Makefile                        |    9 +
 sound/soc/rockchip/rockchip_machine_driver.c       |  222 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_machine_driver.h       |   41 ++++
 sound/soc/rockchip/rockchip_max98090.c             |  185 ++++++++++++++++
 sound/soc/rockchip/rockchip_rt5645.c               |  220 +++++++++++++++++++
 7 files changed, 741 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-machine.txt
 create mode 100644 sound/soc/rockchip/rockchip_machine_driver.c
 create mode 100644 sound/soc/rockchip/rockchip_machine_driver.h
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

-- 
1.7.9.5
