From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Tue, 13 Oct 2015 09:01:05 +0800
Subject: [PATCH v1 0/4] Audio Codec Driver of RK3036 SoC
Message-ID: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

Base on the other seris of RK3036 clk patches, which is not landed yet,
this patches add the RK3036 SoC codec driver.

Rockchip RK3036 SoC integrated with an Inno audio codec. It supports
the following features:
o. 24bit DAC
o. Support 16? to 32? headphone output and speaker output
o. Support Mono, Stereo channel
o. Sampling rate of 8/12/16/24/32/44.1/48/96KHz

While there are some features like dapm and s2r are still WIP,
I would like to send these patches now and get some feedback.

Thank you for your review.

ZhengShunQian (4):
  ASoC: codec: Inno codec driver for RK3036 SoC
  ASoC: RK3036: Add binding doc of inno-rk3036 codec driver
  ASoC: Add codec machine driver for RK3036
  ASoC: RK3036: Add binding doc for audio machine driver

 .../devicetree/bindings/sound/inno-rk3036.txt      |  20 +
 .../devicetree/bindings/sound/rockchip-rk3036.txt  |  14 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/inno_rk3036.c                     | 439 +++++++++++++++++++++
 sound/soc/codecs/inno_rk3036.h                     | 308 +++++++++++++++
 sound/soc/rockchip/Kconfig                         |  10 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_rk3036.c               | 147 +++++++
 9 files changed, 946 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rk3036.txt
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h
 create mode 100644 sound/soc/rockchip/rockchip_rk3036.c

-- 
1.9.1
