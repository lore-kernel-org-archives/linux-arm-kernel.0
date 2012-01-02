From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 02 Jan 2012 11:24:31 +0530
Subject: [RFC][PATCH 0/4] lcd: platform-lcd: Add lcd panel and device tree
 support
Message-ID: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform-lcd driver depends on platform-specific callbacks to setup the
lcd panel. These callbacks are supplied using driver's platform data. But
for adding device tree support for platform-lcd driver, providing such
callbacks is not possible (without using auxdata).

Since the callbacks are usually lcd panel specific, it is possible to include
the lcd panel specific setup and control functionality in the platform-lcd
driver itself, thereby eliminating the need for supplying platform specific
callbacks to the driver. The platform-lcd driver can include support for
multiple lcd panels.

This patchset removes the need for platform data for platform-lcd driver and
adds support which can be used to implement lcd panel specific functionality
in the driver. As an example, the support for Hydis hv070wsa lcd panel is added
to the platform-lcd driver which is then used on the Exynos4 based Origen board.
This currently breaks build for other users of platform-lcd driver. Those can be
fixed if this approach is acceptable.

Thomas Abraham (4):
  lcd: platform-lcd: Eliminate need for platform data
  lcd: platform-lcd: Add support for Hydis hv070wsa lcd panel
  ARM: Exynos: Remove platform data of platform-lcd driver
  lcd: platform-lcd: Add device tree support

 arch/arm/mach-exynos/mach-origen.c     |   25 +-----
 drivers/video/backlight/Kconfig        |    6 ++
 drivers/video/backlight/platform_lcd.c |  128 ++++++++++++++++++++++++++++---
 include/video/platform_lcd.h           |   11 +--
 4 files changed, 129 insertions(+), 41 deletions(-)
