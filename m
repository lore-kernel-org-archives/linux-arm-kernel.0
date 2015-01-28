From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 28 Jan 2015 17:27:54 +0800
Subject: [PATCH 0/2] Add Mediatek RTC driver 
Message-ID: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series 
support RTC driver that work with Mediatek SoC like MT8135, MT8173.
It implements second counter and also provide alarm function.

This series base on 3.19-rc1, and Sascha's PMIC mfd patch[1]. Test ok 
on MT8135 platform.

[1] https://lkml.org/lkml/2015/1/23/325

Eddie Huang (1):
  dt: bindings: Add Mediatek RTC driver binding document

Tianping Fang (1):
  rtc: mediatek: Add MT63xx RTC driver

 .../bindings/rtc/mediatek,mt63xx-rtc.txt           |  18 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-mt6397.c                           | 352 +++++++++++++++++++++
 4 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt
 create mode 100644 drivers/rtc/rtc-mt6397.c

-- 
1.8.1.1.dirty
