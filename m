From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 23:54:06 +0200
Subject: [PATCH 0/9] v4.8 build regressions
Message-ID: <20160810215424.1926658-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a set of patches to address build warnings and errors that have
come up in linux-4.8 but that worked fine in v4.7. I've added the
tinyconfig warning patch in there as well, which is not a regression
but is something that shows up in the kernelci.org build bots.
The other patches address issues that either came up in kernelci.org
or in my randconfig test setup.

I have three more fixes queued up in arm-soc/fixes that I plan
to send as a pull request for -rc2 along with the other bugfixes.

All patches have been posted before, but for some reason or another
failed to make it into the merge window. I have updated the ones
that were waiting for a new version from me now, the others are
sent without modifications.

Hopefully we can get them all merged into v4.8. Please pick up
patches from the middle of the series if appropriate.

	Arnd

Arnd Bergmann (7):
  kconfig: tinyconfig: provide whole choice blocks to avoid warnings
  dsa: mv88e6xxx: hide unused functions
  drm/mediatek: add COMMON_CLK dependency
  drm/mediatek: add CONFIG_OF dependency
  drm/mediatek: add ARM_SMCCC dependency
  clocksource: kona: fix get_counter error handling
  8250/fintek: rename IRQ_MODE macro

Geert Uytterhoeven (1):
  test/hash: Fix warning in two-dimensional array init

George Spelvin (1):
  test/hash: Fix warning in preprocessor symbol evaluation

 arch/x86/configs/tiny.config          |  2 ++
 drivers/clocksource/bcm_kona_timer.c  | 16 ++++++++++------
 drivers/gpu/drm/mediatek/Kconfig      |  3 +++
 drivers/net/dsa/mv88e6xxx/chip.c      |  2 ++
 drivers/tty/serial/8250/8250_fintek.c |  4 ++--
 kernel/configs/tiny.config            |  8 ++++++++
 lib/test_hash.c                       |  8 ++++----
 7 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.9.0

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: George Spelvin <linux@sciencehorizons.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: kernel-build-reports at lists.linaro.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: netdev at vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: x86 at kernel.org
