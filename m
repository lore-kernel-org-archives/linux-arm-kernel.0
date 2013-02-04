From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Feb 2013 15:41:58 -0800
Subject: [GIT PULL 3/5] Samsung irq-s3c24xx for v3.9
Message-ID: <120d01ce0331$39efc9e0$adcf5da0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is redoing the s3c24xx irqs in a generic way by using a declarative
approach.
Note, this is based on previous pull-request, ' next/cleanup-s3c24xx'
branch.

If any problems, please kindly let me know.

Thanks.

- Kukjin


The following changes since commit acf2d41d8595829eb0ac7bf6891f4875a78d4d6e:

  ARM: S3C24XX: Move mach-s3c2440/ pll into mach-s3c24xx/ (2013-01-21
17:05:23 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/irq-s3c24xx

for you to fetch changes up to f44ddba3635e35317057e976888d4a12dcb0f842:

  ARM: S3C24XX: transform s3c2443 subirqs into new structure (2013-02-03
15:52:50 -0800)

----------------------------------------------------------------
Heiko Stuebner (9):
      ARM: S3C24XX: transform irq handling into a declarative form
      ARM: S3C24XX: Move irq syscore-ops to irq-pm
      ARM: S3C24XX: Modify s3c_irq_wake to use the hwirq property
      ARM: S3C24XX: move s3c2416 irq init to common irq code
      ARM: S3C24XX: modify s3c2416 irq init to initialize all irqs
      ARM: S3C24XX: transform s3c2416 irqs into new structure
      ARM: S3C24XX: move s3c2443 irq code to irq.c
      ARM: S3C24XX: modify s3c2443 irq init to initialize all irqs
      ARM: S3C24XX: transform s3c2443 subirqs into new structure

 arch/arm/mach-s3c24xx/Makefile               |    4 +-
 arch/arm/mach-s3c24xx/common.h               |    2 +
 arch/arm/mach-s3c24xx/irq-pm.c               |   41 +++-
 arch/arm/mach-s3c24xx/irq-s3c2416.c          |  348
----------------------------
 arch/arm/mach-s3c24xx/irq-s3c2443.c          |  281 -----------------------
 arch/arm/mach-s3c24xx/mach-smdk2416.c        |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c        |    2 +-
 arch/arm/mach-s3c24xx/s3c2410.c              |    4 +-
 arch/arm/mach-s3c24xx/s3c2412.c              |    3 +-
 arch/arm/mach-s3c24xx/s3c2416.c              |    4 +-
 arch/arm/mach-s3c24xx/s3c2440.c              |    4 +-
 arch/arm/mach-s3c24xx/s3c2442.c              |    4 +-
 arch/arm/plat-s3c24xx/Kconfig                |    1 +
 arch/arm/plat-s3c24xx/irq.c                  | 1110
++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
-------------
 arch/arm/plat-samsung/include/plat/pm.h      |    6 -
 arch/arm/plat-samsung/include/plat/s3c2416.h |    1 +
 arch/arm/plat-samsung/include/plat/s3c2443.h |    2 +
 17 files changed, 687 insertions(+), 1132 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2443.c
