From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 6 May 2015 15:23:39 +0800
Subject: [PATCH v4 0/3] Add Mediatek SoC RTC driver 
Message-ID: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series
support RTC driver that work with Mediatek SoC like MT8135, MT8173.
It implements second counter and also provide alarm function.

This series base on 4.1-rc1, Test ok on MT8173 platform.

[1] https://lkml.org/lkml/2015/1/23/325

Change in v4:
1. Align mt6397-core.c resource in straight lines.
2. Modify mtk_rtc_write_trigger according Joe Perches and
   Alexandre Belloni suggestion.
3. Align function parameters to the open parenthesis.
4. Modify MAINTAINER to use file full name.

Change in v3:
1. Replace magic number in mt6397-core.c
2. Add comment for some equation and write trigger.
3. Use regmap_bulk_read and regmap_bulk_write to avoid muliple regmap_read
   and regmap_write
4. Replace devm_request_threaded_irq with request_threaded_irq and add
   irq_dispose_mapping
5. Fix Tomasz Figa review comment.

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
9. Fix Uwe Kleine-K?nig review comment

Eddie Huang (2):
  mfd: provide RTC resource in MT6397 MFD
  MAINTAINERS: add Mediatek RTC driver

Tianping Fang (1):
  rtc: mediatek: Add MT6397 RTC driver

 MAINTAINERS               |   7 +
 drivers/mfd/mt6397-core.c |  18 +++
 drivers/rtc/Kconfig       |  10 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-mt6397.c  | 394 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 drivers/rtc/rtc-mt6397.c

--
1.8.1.1.dirty
