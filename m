From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Feb 2016 15:02:43 -0800
Subject: [PATCH 0/7] PM runtime regression fixes for omaps
Message-ID: <1455145370-20301-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some PM runtime regression fixes for omaps after recent
pm_runtime_reinit changes.

We basically have to use pm_runtime_put_sync_suspend() or
a combination of pm_runtime_dont_use_autosuspend() and
pm_runtime_put_sync() if the driver has enabled autoidle.

If no objections, I'd like to merge this whole series via
the ARM SoC tree.

Regards,

Tony


Tony Lindgren (7):
  mmc: omap_hsmmc: Fix PM regression with deferred probe for
    pm_runtime_reinit
  i2c: omap: Fix PM regression with deferred probe for pm_runtime_reinit
  spi: omap2-mcspi: Fix PM regression with deferred probe for
    pm_runtime_reinit
  serial: 8250_omap: Fix PM regression with deferred probe for
    pm_runtime_reinit
  serial: omap: Fix PM regression with deferred probe for
    pm_runtime_reinit
  ARM: OMAP2+: Improve omap_device error for driver writers
  ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid

 arch/arm/mach-omap2/omap_device.c   | 14 +++++++++++++-
 drivers/i2c/busses/i2c-omap.c       |  4 +++-
 drivers/mmc/host/omap_hsmmc.c       |  6 ++++--
 drivers/spi/spi-omap2-mcspi.c       |  3 +++
 drivers/tty/serial/8250/8250_omap.c |  4 +++-
 drivers/tty/serial/omap-serial.c    |  4 +++-
 6 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.7.0
