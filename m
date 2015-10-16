From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 16 Oct 2015 14:27:24 +0200
Subject: [RFC PATCH 0/3] pwm: omap: Add PWM support using dual-mode timers
Message-ID: <5620ED2C.1090107@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on an earlier patch by NeilBrown which is based on
a older patch from Grant Erickson which provided PWM devices using
the 'legacy' interface.

The pwm driver was renamed to not be confused with the OMAP4 PWM dedicated
hardware and was cleaned with the review from Thierry Reding.

The first patch introduces a way to select to dmtimer clock source via a
clocks binding and a dedicated function wit the legacy fallback.

In order to prepare for the future form of the dmtimer (clksource or whatever)
the first patch introduces the PWM driver with all the dmtimer calls into a
platform data structure.

The structure is then filled in plat-omap and added as auxdata for the
ti,pwm-dmtimer-omap compatible nodes.

Cc: Grant Erickson <marathon96@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Joachim Eastwood <manabian@gmail.com>
Suggested-by: Tony Lindgren <tony@atomide.com>

Neil Armstrong (3):
  arm: plat-omap: dmtimer: Add clock source from DT
  pwm: Add PWM driver for OMAP using dual-mode timers
  arm: plat-omap: Add PWM dmtimer platforma data quirks

 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
 arch/arm/mach-omap2/pdata-quirks.c                 |  23 ++
 arch/arm/plat-omap/dmtimer.c                       |  32 +-
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++++++++
 include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
 7 files changed, 472 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
 create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
 create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
1.9.1
