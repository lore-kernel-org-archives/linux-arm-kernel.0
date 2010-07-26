From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 26 Jul 2010 22:04:38 +0200
Subject: [PULL] Various xscale fixes
Message-ID: <201007262204.39318.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric, can you please pull these changes into your -devel? Thanks!

The following changes since commit 9f5f3423ac0d786ff87ee80e7c5292b43fe0b4f9:

  Merge branch 'devel' of 
git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6 into devel 
(2010-07-22 17:14:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.git for-
eric-devel

Marek Vasut (8):
      pxa: Introduce Palm27x
      pxa: Flip Palm LD, TX, T5, Z72 to Palm27x
      pxa: Add core pmic support for Palm27x
      pxa: Modularize remnants of code in Palms
      pxa/spitz: Rework spitz
      pxa/spitz: Formating and naming fixes
      PXA: Fix ZipitZ2 flash layout typo
      Merge branch 'palm' into for-eric-devel

 arch/arm/mach-pxa/Kconfig                |    7 +
 arch/arm/mach-pxa/Makefile               |    1 +
 arch/arm/mach-pxa/include/mach/palm27x.h |   48 ++
 arch/arm/mach-pxa/include/mach/spitz.h   |    6 +
 arch/arm/mach-pxa/palm27x.c              |  532 ++++++++++++++++++++++
 arch/arm/mach-pxa/palmld.c               |  301 +++----------
 arch/arm/mach-pxa/palmt5.c               |  289 ++-----------
 arch/arm/mach-pxa/palmtreo.c             |  371 +++-------------
 arch/arm/mach-pxa/palmtx.c               |  307 +++-----------
 arch/arm/mach-pxa/palmz72.c              |  269 ++----------
 arch/arm/mach-pxa/spitz.c                |  724 ++++++++++++++++++------------
 arch/arm/mach-pxa/z2.c                   |    2 +-
 12 files changed, 1265 insertions(+), 1592 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palm27x.h
 create mode 100644 arch/arm/mach-pxa/palm27x.c
