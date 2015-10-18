From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 18 Oct 2015 18:00:11 +0200
Subject: [PATCH 0/4] VFIO platform reset module rework
Message-ID: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes the current implementation by getting rid of the
usage of __symbol_get which caused a compilation issue with
CONFIG_MODULES disabled. On top of this, the usage of MODULE_ALIAS makes
possible to add a new reset module without being obliged to update the
framework. The new implementation relies on the reset module registering
its reset function to the vfio-platform driver.

The series is available at

https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.3-rc5-rework-xgbe-v2

Best Regards

Eric


Eric Auger (4):
  vfio: platform: add capability to register a reset function
  vfio: platform: reset: calxedaxgmac: add reset function registration
  vfio: platform: add compat in vfio_platform_device
  vfio: platform: use list of registered reset function

 .../platform/reset/vfio_platform_calxedaxgmac.c    |  40 +++++++-
 drivers/vfio/platform/vfio_platform_common.c       | 112 ++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h      |  16 +++
 3 files changed, 140 insertions(+), 28 deletions(-)

-- 
1.9.1
