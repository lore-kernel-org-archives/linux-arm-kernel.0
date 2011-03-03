From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  3 Mar 2011 14:30:54 +0100
Subject: [PATCH] remove kconfig dependencies from ARCH_MX*/MACH_MX*
Message-ID: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series changes several i.MX relevant kconfig entries
to depend on IMX_HAVE_PLATFORM_* macros instead of depending on
indiviual i.MX variants.

Sascha

The following changes since commit cbdbb4c1d22e26f9d5314fefe6f2c7e5ed7f6a0f:

  Merge branch 'drm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2011-03-02 20:02:32 -0800)

are available in the git repository at:

  none ..BRANCH.NOT.VERIFIED..

Sascha Hauer (6):
      media/video i.MX: use IMX_HAVE_PLATFORM_* macros
      rtc i.MX Dryice: use IMX_HAVE_PLATFORM_IMXDI_RTC to depend on
      usb i.MX21: use IMX_HAVE_PLATFORM_IMX21_HCD to depend on
      video i.MX: remove mx1 compile time dependencies
      watchdog i.MX: use IMX_HAVE_PLATFORM_IMX2_WDT to depend on
      mmc i.MX sdhci: use IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX to depend on

 drivers/media/video/Kconfig |    4 ++--
 drivers/mmc/host/Kconfig    |    2 +-
 drivers/rtc/Kconfig         |    2 +-
 drivers/usb/host/Kconfig    |    2 +-
 drivers/video/Kconfig       |    2 +-
 drivers/video/imxfb.c       |   28 ++++++----------------------
 drivers/watchdog/Kconfig    |    2 +-
 7 files changed, 13 insertions(+), 29 deletions(-)
