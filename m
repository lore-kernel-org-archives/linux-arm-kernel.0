From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 06:34:02 +1300
Subject: [PATCH RESEND 0/6] Remove incorrect usage of IS_ERR_OR_NULL on clk_get
Message-ID: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend to include mailing lists.

As per the kernel docs, clk_get() cannot return NULL.

 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock consumer ID
 *
 * Returns a struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.

This patch set replaces instances of IS_ERR_OR_NULL tests againt clk_get()
results with IS_ERR tests.

Tony Prisk (6):
  clk: omap: Fix incorrect usage of IS_ERR_OR_NULL
  clk: exynos: Fix incorrect usage of IS_ERR_OR_NULL
  clk: exynos: Fix incorrect usage of IS_ERR_OR_NULL
  clk: s5p-tv: Fix incorrect usage of IS_ERR_OR_NULL
  clk: s5p-fimc: Fix incorrect usage of IS_ERR_OR_NULL
  clk: s5p-g2d: Fix incorrect usage of IS_ERR_OR_NULL

 arch/arm/plat-omap/dmtimer.c                   |    6 +++---
 drivers/gpu/drm/exynos/exynos_hdmi.c           |   10 +++++-----
 drivers/gpu/drm/exynos/exynos_mixer.c          |   14 +++++++-------
 drivers/media/platform/s5p-fimc/fimc-mdevice.c |    2 +-
 drivers/media/platform/s5p-g2d/g2d.c           |    4 ++--
 drivers/media/platform/s5p-tv/hdmi_drv.c       |   10 +++++-----
 drivers/media/platform/s5p-tv/mixer_drv.c      |   10 +++++-----
 drivers/media/platform/s5p-tv/sdo_drv.c        |   10 +++++-----
 8 files changed, 33 insertions(+), 33 deletions(-)

-- 
1.7.9.5
