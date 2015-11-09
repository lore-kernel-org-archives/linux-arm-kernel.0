From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Mon,  9 Nov 2015 10:10:18 +0800
Subject: [PATCH v4 0/2] Audio Codec Driver of RK3036 SoC
Message-ID: <1447035020-10332-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

This patches add the RK3036 SoC codec driver.

Rockchip RK3036 SoC integrated with an Inno audio codec. It supports
the following features:
o. 24bit DAC
o. Support 16? to 32? headphone output and speaker output
o. Support Mono, Stereo channel
o. Sampling rate of 8/12/16/24/32/44.1/48/96KHz

Changes of v4:
o. Use the custom .get/.put/.info() for "Anti-pop Switch" control

Changes of v3:
o. Fix the search/replace error in inno_rk3036.h
o. Change the compatible string in bindings Documentation
o. Make some changes from upstream's comments

Changes of v2:
o. Delete the machine driver in v1, it's better to use
   simple-card machine driver.
o. Use the dapm to manage power sequences and make some
   functions as user visible control.
o. Make some changes from upstream's comments.


ZhengShunQian (2):
  ASoC: codec: Inno codec driver for RK3036 SoC
  ASoC: RK3036: Add binding doc of inno-rk3036 codec driver

 .../devicetree/bindings/sound/inno-rk3036.txt      |  20 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/inno_rk3036.c                     | 491 +++++++++++++++++++++
 sound/soc/codecs/inno_rk3036.h                     | 123 ++++++
 5 files changed, 640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h

-- 
1.9.1
