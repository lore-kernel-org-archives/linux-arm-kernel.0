From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Mar 2012 13:49:35 -0700
Subject: [GIT PULL] gpio/omap: more fixes for v3.4
Message-ID: <871uok5pk0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Please pull these OMAP GPIO fixes for v3.4.  These fix some rather
serious regressions introduced by the cleanup and runtime PM conversion
series which is also queued for v3.4.  This branch is based on your
gpio/next branch.

This version is functionally the same as the version you previously
merged (and I asked you to back it out), but this version has some
better changlogs, and I added reviewed-by and s-o-b from me as well.

Thanks,

Kevin



The following changes since commit 81b279d80a63628e580c71a31d30a8c3b3047ad4:

  gpio/davinci: fix enabling unbanked GPIO IRQs (2012-03-12 11:53:33 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/fixes/gpio-2

for you to fetch changes up to 7fcca715de3438b8fc3c8a144702f3a95c8ff63c:

  gpio/omap: fix redundant decoding of gpio offset (2012-03-21 10:21:24 +0530)

----------------------------------------------------------------
Tarun Kanti DebBarma (7):
      gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
      gpio/omap: fix trigger type to unsigned
      gpio/omap: fix _set_gpio_irqenable implementation
      gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg
      gpio/omap: fix incorrect context restore logic in omap_gpio_runtime_*
      gpio/omap: fix incorrect update to context.irqenable1
      gpio/omap: fix redundant decoding of gpio offset

 drivers/gpio/gpio-omap.c |   47 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)
