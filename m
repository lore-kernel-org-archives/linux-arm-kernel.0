From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Feb 2012 08:36:27 +0100
Subject: [GIT PULL] ux500 patches for v3.4
Message-ID: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Arnd, Olof,

here are some accumulated patches for ux500 from the mailing
list, intended for the next (3.4) merge window.

In order to somewhat make sure that they do not unnecessary
conflict with other stuff in the tree I pulled the whole
shebang into a branch off yesterdays linux-next and it worked
just fine, so it should be orthogonal to other changes.

The main change is support for a new ASIC variant in the
families named DB9540 and its platform the U9540.

Thanks,
Linus Walleij


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/ for-arm-soc-20120220

Linus Walleij (1):
      ARM: ux500: core U9540 support

Michel Jaouen (1):
      ARM: ux500: ioremap differences for DB9540

Ola Lilja (3):
      ARM: ux500: Add placeholder for clk_set_parent
      ARM: ux500: Add DMA-channels for MSP
      ARM: ux500: Add audio-regulators

Philippe Langlais (2):
      ARM: ux500: set ARCH_NR_GPIO to 355 on U8500 platforms
      ARM: ux500: fix around AB8500 GPIO macro name

 arch/arm/Kconfig                               |    2 +-
 arch/arm/mach-ux500/board-mop500-regulators.c  |   28 +++++++++++
 arch/arm/mach-ux500/board-mop500-uib.c         |    2 +-
 arch/arm/mach-ux500/board-mop500.c             |    2 +-
 arch/arm/mach-ux500/board-mop500.h             |    2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   14 +++++-
 arch/arm/mach-ux500/clock.c                    |    9 +++-
 arch/arm/mach-ux500/clock.h                    |    1 +
 arch/arm/mach-ux500/cpu-db8500.c               |   24 ++++++++--
 arch/arm/mach-ux500/cpu.c                      |    4 +-
 arch/arm/mach-ux500/devices-db8500.c           |    6 +++
 arch/arm/mach-ux500/id.c                       |   26 +++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    6 +++
 arch/arm/mach-ux500/include/mach/hardware.h    |   12 +++++
 arch/arm/mach-ux500/include/mach/id.h          |   17 +++++++-
 arch/arm/mach-ux500/include/mach/irqs-db9540.h |   58 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/irqs.h        |    3 +-
 arch/arm/mach-ux500/include/mach/setup.h       |    7 +++
 arch/arm/mach-ux500/platsmp.c                  |    4 +-
 arch/arm/mach-ux500/timer.c                    |    2 +-
 drivers/cpufreq/db8500-cpufreq.c               |    2 +-
 21 files changed, 212 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs-db9540.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPQ0ikAAoJEEEQszewGV1zB0wP/jeRLhLzYPYMOrJZR0ZD2ntR
uMukCtAnqaxxOtIv7vNT9Zy6duzmtiUUyfK8wwicLusT2oaiIubFcXgMC0FRERe9
dFlRMxyBU6CXX7piJjgZ6wedZzRqB8yiuMjKUbpMnPdhAr3BZDcxv4UuCnjZYfxd
Hhboj0+wZm2qyvFYTGzMyPlTkzoXddHMDC4DsFDUifouPu9ovJeiCJlmXfPT0HYf
tlE9Dytp6axtWUVlGduEMEgNU4IUUDxGOBtECSfqHAt0yyI28dGk0lftewiU3uj8
RwEuW88BJXX66aVTBVhsdealEkSjK48UFzCAs8A39LGhz0bT60GmI6GCS+yO89Cf
feX8Qejxm3YzHUzWN3ZI2c6SHYrdOtoqlNSuvYdhjfa3vfCstYGRXB7pgVgBqSrS
npbRhYkzGYcY8PZKcNBnC/1xtKE11UCb56CujteTAtsKALGZNZv8nmpGcHmRVmX9
YBgwA/c/p+/G5DyMe4V8tWE0hYfyVmkRUBAtCINDje4BRhuDVtE7HhGKEPZtgKvw
ZVV3UfXVE5/qEoZ5u5xHS9OwbHZEQQdgUN7QwpBjUSue9QO4rz3iN2Gu0YMWtp2I
F+hNBcGelAafL7ohqBa1xnTz7pgwV81VUWzGiqcG2htmLY2KblBUnZIIk0jvNC1u
XoXMj6/h2ta0xFrMT3ys
=3MW5
-----END PGP SIGNATURE-----
