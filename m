From: j-keerthy@ti.com (Keerthy)
Date: Wed, 16 May 2018 11:10:28 +0530
Subject: [PATCH 0/2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl contex
Message-ID: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds save/restore functions to pinctrl-single driver.
This is specially needed in case of RTC only mode with
DDR in self refresh where the register contents are lost.

Tested on am437x-gp-evm.

Keerthy (2):
  arm: mach-omap2: pdata-quirks: Add a quirk function to convey off mode
    state
  pinctrl: pinctrl-single: Add functions to save and restore pinctrl
    context

 arch/arm/mach-omap2/pdata-quirks.c           |  6 ++
 drivers/pinctrl/pinctrl-single.c             | 95 +++++++++++++++++++++++++++-
 include/linux/platform_data/pinctrl-single.h |  1 +
 3 files changed, 101 insertions(+), 1 deletion(-)

-- 
1.9.1
