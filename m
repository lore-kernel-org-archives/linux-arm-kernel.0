From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 03:49:18 +0530
Subject: [PATCH 0/4] Add Device tree support for 88PM800 mfd and rtc driver
Message-ID: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-series adds support for Device tree to 88PM800 mfd and rtc driver.
It also creates the DT binding for 88pm800 driver.

Testing::
 - Boot tested on PXA1928 based platform.
 - probe of mfd, rtc and regulator function passing.


Attempt has been made to push some of the patches to the list sometime
back in 2013.

Link to previous patch submission:
        https://lkml.org/lkml/2013/8/14/86


Vaibhav Hiremath (4):
  mfd: 88pm800: add device tree support
  mfd: 88pm800: use irq_mode to configure interrupt status reg clear
    method
  rtc: 88pm80x: add device tree support
  mfd: 88pm800: allocate pdata->rtc if not allocated earlier

 Documentation/devicetree/bindings/mfd/88pm800.txt | 57 +++++++++++++++++++++
 drivers/mfd/88pm800.c                             | 62 ++++++++++++++++++++++-
 drivers/rtc/rtc-88pm80x.c                         | 28 ++++++----
 include/linux/mfd/88pm80x.h                       |  2 +
 4 files changed, 137 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

-- 
1.9.1
