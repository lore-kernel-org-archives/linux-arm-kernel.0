From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 21 Jul 2015 21:53:00 +0530
Subject: [PATCH-v2 0/2] regulator: 88pm800: Add dual phase mode support on
 BUCK1
Message-ID: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 device supports dual phase mode on BUCK1 output.
In normal usecase, BUCK1A and BUCK1B operates independently with 3A
capacity. And they both can work as a dual phase providing 6A capacity.

This patch series is subset of earlier patch-series
Link to earlier series - https://lkml.org/lkml/2015/7/16/722

Except PATCH[5/5], all other patches in the series are accepted and
queued up for next merge window.
And based on discussion on the list, creating DT property to enable
dual-phase mode on BUCK1.

Testing:
 - Tested on 88PM860 based platform
 - Boot tested 
 - Tested with & without DT property being set
 - Read register value before and after probe to make sure that
   value has been set.

V1 => V2:
========
 - This is new patch-series, where, all accepted patches dropped.
   Upgraded Patch version, to ease review.
 - Based on Mark Brown's comment, we should use DT proeprty of its own.
   using set_current_limit() is not right way here.
   So, created DT property for Dual phase mode enable.
 - Updated binding for new DT property


Vaibhav Hiremath (2):
  mfd: devicetree: bindings: 88pm800: Add DT property for dual phase
    enable
  regulator: 88pm800: Add support for configuration of dual phase on
    BUCK1

 Documentation/devicetree/bindings/mfd/88pm800.txt |  6 +++++
 drivers/regulator/88pm800.c                       | 31 +++++++++++++++++++++++
 include/linux/mfd/88pm80x.h                       |  3 +++
 3 files changed, 40 insertions(+)

-- 
1.9.1
