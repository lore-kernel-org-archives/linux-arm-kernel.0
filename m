From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 18 Jun 2015 00:28:04 +0530
Subject: [PATCH-v2 0/3] mfd: 88pm800: Add Device tree support
In-Reply-To: <vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
Message-ID: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-series adds support for Device tree to 88PM800 mfd driver.
It also enabled configuration of irq clear method through DT.

Testing::
 - Boot tested on PXA1928 based platform.
 - probe of mfd, rtc and regulator function passing successfully.
 - Basic read operations on registers


V1 => V1
=======
Link to V1: http://lkml.iu.edu/hypermail/linux/kernel/1505.3/04386.html

  - Split binding changes from original commit
  - Updated binding info as per Rob's suggestion
  - Dropped PATCH 4/4, as discussed during review
  - Dropped PATCH 3/4, as it is independent RTC code change,
    so will submit it separately to ease merging.
  - Fixed all other minor comments

Attempt has been made to push some of the patches to the list sometime
back in 2013.

Link to previous patch submission:
        https://lkml.org/lkml/2013/8/14/86

Vaibhav Hiremath (3):
  mfd: 88pm800: Add device tree support
  mfd: 88pm800: Allow configuration of interrupt clear method
  mfd: devicetree: bindings: Add new 88pm800 mfd binding

 Documentation/devicetree/bindings/mfd/88pm800.txt | 60 +++++++++++++++++++++++
 drivers/mfd/88pm800.c                             | 40 +++++++++++++--
 include/linux/mfd/88pm80x.h                       |  6 ++-
 3 files changed, 99 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

-- 
1.9.1
