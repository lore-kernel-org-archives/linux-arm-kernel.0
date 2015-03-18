From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 18 Mar 2015 13:45:34 +0800
Subject: [PATCH v2 0/3] Add Mediatek SoC RTC driver 
Message-ID: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series 
support RTC driver that work with Mediatek SoC like MT8135, MT8173.
It implements second counter and also provide alarm function.

This series base on 4.0-rc1, and Sascha's PMIC mfd patch[2]. Test ok 
on MT8173 platform.

[1] https://lkml.org/lkml/2015/1/23/325
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/324985.html

Change in v2:
1. Move RTC address and interrupt to mt6397-core.c, and register 
   these resource in mfd_cell.
   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323239.html
2. Remove dt-binding document due to register resouce in mfd_cell, not from 
   device tree.
3. Update MAINTAINER file to add Mediatek RTC mainainter.
4. Add prefix mtk_ to some internal functions.
5. Fix racy condition
6. Check return value of regmap_read and regmap_write
7. Remove some unnecessary register readback, clear, then write.
8. Add disable alarm in mtk_rtc_set_alarm function

v1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320424.html

Eddie Huang (2):
  mfd: provide RTC resource in MT6397 MFD
  MAINTAINERS: add Mediatek RTC driver

Tianping Fang (1):
  rtc: mediatek: Add MT6397 RTC driver

 MAINTAINERS               |   7 +
 drivers/mfd/mt6397-core.c |  15 ++
 drivers/rtc/Kconfig       |  10 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-mt6397.c  | 454 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 487 insertions(+)
 create mode 100644 drivers/rtc/rtc-mt6397.c

-- 
1.8.1.1.dirty
