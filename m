From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Jun 2014 10:23:42 +0200
Subject: [GIT PULL] Versatile/Integrator base cleanup patches
Message-ID: <CACRpkdbMA2oCFJmKH91MSg4hA0dxGcgAzy=ph1YOBLkN6-KxZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these are the first basic patches at the very bottom of my
multiplatform stack, getting some infrastructure in place to
do the final transition to multiplatform for Integrator (still
working on the final patch) and also paving the road a bit
for Versatile and RealView but continuing to depopulate
plat-versatile.

Please pull it in as a starter, I'd recommend a common
Versatile branch to be shared with e.g. Rob Herrings Versatile
devicetree stuff.

Yours,
Linus Walleij


The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-1

for you to fetch changes up to 11c32d7b6274cb0f554943d65bd4a126c4a86dcd:

  video: move Versatile CLCD helpers (2014-06-27 10:15:22 +0200)

----------------------------------------------------------------
First pull request of Versatile family clean-ups for v3.17:

- Remove <mach/memory.h> from the Integrator, paving the
  road for multiplatform.
- Push the CLCD helper code down into the framebuffer subsystem,
  removing the last hook in plat-versatile for the Integrator,
  also paving the road for multiplatform.

Patches tested on Integrator/AP, Integrator/CP and Versatile AB
(all real hardware).

----------------------------------------------------------------
Linus Walleij (2):
      ARM: integrator: get rid of <mach/memory.h>
      video: move Versatile CLCD helpers

 arch/arm/Kconfig                                   |  1 -
 arch/arm/boot/dts/integratorap.dts                 |  1 +
 arch/arm/mach-integrator/Kconfig                   |  1 -
 arch/arm/mach-integrator/include/mach/memory.h     | 34 ----------------------
 arch/arm/mach-integrator/integrator_cp.c           |  3 +-
 arch/arm/mach-realview/core.c                      |  2 +-
 arch/arm/mach-versatile/core.c                     |  2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |  3 +-
 arch/arm/plat-versatile/Kconfig                    |  3 --
 arch/arm/plat-versatile/Makefile                   |  1 -
 drivers/video/fbdev/Kconfig                        |  7 +++++
 drivers/video/fbdev/Makefile                       |  1 +
 .../video/fbdev/amba-clcd-versatile.c              |  2 +-
 .../linux/platform_data/video-clcd-versatile.h     |  0
 14 files changed, 14 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/memory.h
 rename arch/arm/plat-versatile/clcd.c =>
drivers/video/fbdev/amba-clcd-versatile.c (98%)
 rename arch/arm/plat-versatile/include/plat/clcd.h =>
include/linux/platform_data/video-clcd-versatile.h (100%)
