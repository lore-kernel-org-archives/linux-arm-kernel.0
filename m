From: leo.yan@linaro.org (Leo Yan)
Date: Wed,  4 Apr 2018 11:14:30 +0800
Subject: [PATCH 0/5] Hi3660: enable power management features
Message-ID: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since hi3660 drivers have been merged into Linux kernel (mailbox driver is in
Linux-next branch and other drivers are existed in Linux mainline kernel), so
this patch series is to enable power management features on hi3660.

This patch series includes device tree binding for mailbox, stub clock and CPU
OPPs, and has one patch to consolidate the Kconfigs for driver modules.

This patch set have been tested on Hikey960 and also verified the patch 'hisi:
Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX' for Hikey620.


Daniel Lezcano (1):
  hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX

Kaihua Zhong (2):
  dts: arm64: hi3660: Add mailbox node
  dts: arm64: hi3660: Add stub clock node

Leo Yan (1):
  dts: arm64: hi3660: Add CPU frequency scaling support

Tao Wang (1):
  dts: arm64: hi3660: Add thermal cooling management

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 145 ++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   1 -
 drivers/clk/hisilicon/Kconfig             |  13 +--
 drivers/mailbox/Kconfig                   |  12 ++-
 4 files changed, 161 insertions(+), 10 deletions(-)

-- 
1.9.1
