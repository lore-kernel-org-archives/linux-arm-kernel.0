From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  1 Mar 2012 19:34:07 +0100
Subject: [GIT PULL] ux500 fixes for v3.4, take 3
Message-ID: <1330626847-3266-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM-SoC maintainers,

here is an updated pull request for the 3.4 merge window, and I
still expect it to be pretty orthogonal to most other stuff going on
except for maybe Lee Jones' SoC bus patches.

I've left the two U9540 patches off this pull request, I may
present these separately if I get to test the fix suggested
by Arnd, in the meantime this is up for grabs.

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/ ux500-fixes-20120301

Arnd Bergmann (4):
      ARM: ux500: U8500 depends on MMU
      ARM: ux500: add board autoselection
      ARM: ux500: select L2X0 cache on ux500
      ARM: ux500: select CPU_FREQ_TABLE where needed

Danny Kukawka (1):
      ARM: ux500: included linux/gpio.h twice

Linus Walleij (2):
      ARM: ux500: delete TPS6105X selection
      ARM: ux500: solve some Kconfig mess

Ola Lilja (3):
      ARM: ux500: Add placeholder for clk_set_parent
      ARM: ux500: Add DMA-channels for MSP
      ARM: ux500: Add audio-regulators

Philippe Langlais (2):
      ARM: ux500: set ARCH_NR_GPIO to 355 on U8500 platforms
      ARM: ux500: fix around AB8500 GPIO macro name

 arch/arm/Kconfig                              |    3 +-
 arch/arm/mach-ux500/Kconfig                   |   44 ++++++++++++++----------
 arch/arm/mach-ux500/Makefile                  |    2 +-
 arch/arm/mach-ux500/board-mop500-regulators.c |   28 ++++++++++++++++
 arch/arm/mach-ux500/board-mop500-u8500uib.c   |    1 -
 arch/arm/mach-ux500/board-mop500.c            |    2 +-
 arch/arm/mach-ux500/board-mop500.h            |    2 +-
 arch/arm/mach-ux500/clock.c                   |    7 ++++
 arch/arm/mach-ux500/clock.h                   |    1 +
 arch/arm/mach-ux500/devices-db8500.c          |    6 +++
 arch/arm/mach-ux500/include/mach/hardware.h   |    2 +
 arch/arm/mach-ux500/include/mach/irqs.h       |    2 +-
 12 files changed, 76 insertions(+), 24 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPT8BVAAoJEEEQszewGV1z9M0P/0xD28LoZnz+zclgl0YHiaF2
B0/6kvW+FJgd/TOftT87ct0wMaB19Am4owCtbVVonWhiEb2hhgBvc37j7Xaq/0cc
Gh/6O+/49LMaU2EFJnj4c3KZDEc92Iowk2TlWJpCVdM67Jr8V3REU2+c6qSDtqPO
ZaChLhEyYdwwxBNqHwdsgguI5347svsqsoGzuEQ2yLFLSrNDB0i8duwcD7ORk6dA
rv80JpVyDh29Z7ajbTBZg7J6LzKkBcrEAAgdCjJEzZYXABZfFAvWo7xsAFIgolpS
M5yPhziPWYOvirKgP4n02efGNzsGBD4neiIUWXxdJoFx/tfmYeZ+T9mD2GH/pMwY
ZyGbp1GJ0AWamab3t5Zb6QHVJjC0X2foFL7xFHFvcV6FSOdaMwIk2979dmV3roB+
eppbBvVneYkZ4JLvU6PHFc1ymLRiLexBn1KY60ouF3x2S3UzSJLQpiBP5+r1p1jA
77BNj9psEmwCrM+A/ZTVoySOWPC9r3uTkC+qZtBaUdB+DlLPFnvXjm0tPSAp9eLZ
QC+kNIkgdh17lPTtZxS1f8Of+k51fP3FPatTVrlMhYKnWQY+fNIGAAeMiiqQDDLF
lTBbzBZjme+pIWX4Mv3crSLjnCixyzcleyFuAsF2TTBmdPg45iPLsqeVxnWz8l/w
qGa8Gc8xgoQjez+SUOfj
=P1zq
-----END PGP SIGNATURE-----
