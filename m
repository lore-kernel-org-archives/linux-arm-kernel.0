From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 15:28:26 +0000
Subject: [PATCH v2 0/5] ARM build regressions in 3.8
Message-ID: <1359127711-19070-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is what remains from my previous 15 patch series,
the other patches have largely been obsoleted by
fixes from other people that found the same issues.

The samsung and w90x900 fixes should probably go through
the arm-soc tree, while I'd hope James Morris to pick
up the seccomp one and Dave Airlie to take the
exynos drm patch, but we can also put both into arm-soc
if that makes their lifes easier.

On the compressed/head.S patch, I'm still awaiting
feedback. It's not urgent since it is only a warning.

Arnd Bergmann (5):
  samples/seccomp: be less stupid about cross compiling
  ARM: compressed/head.S: work around new binutils warning
  ARM: samsung: fix assembly syntax for new gas
  ARM: w90x900: fix legacy assembly syntax
  drm/exynos: don't include plat/gpio-cfg.h

 arch/arm/boot/compressed/Makefile                |  2 +-
 arch/arm/boot/compressed/head.S                  | 12 ++++++++++++
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S | 12 ++++++------
 arch/arm/mach-s3c24xx/include/mach/entry-macro.S |  4 ++--
 arch/arm/mach-s3c24xx/pm-h1940.S                 |  2 +-
 arch/arm/mach-s3c24xx/sleep-s3c2410.S            | 12 ++++++------
 arch/arm/mach-s3c24xx/sleep-s3c2412.S            | 12 ++++++------
 arch/arm/mach-w90x900/include/mach/entry-macro.S |  4 ++--
 arch/arm/plat-samsung/include/plat/debug-macro.S | 18 +++++++++---------
 drivers/gpu/drm/exynos/exynos_hdmi.c             |  1 -
 samples/seccomp/Makefile                         |  2 ++
 11 files changed, 47 insertions(+), 34 deletions(-)

-- 
1.7.10.4
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: David Airlie <airlied@linux.ie>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Rob Clark <rob@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: dri-devel at lists.freedesktop.org
