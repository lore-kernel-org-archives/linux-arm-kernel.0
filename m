From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Jan 2015 21:25:54 +0800
Subject: [GIT PULL] CSR new atlas7 machine,
 and delete old marco machine for 3.20
Message-ID: <CAGsJ_4z=SOxGAcr_2BizVUvxY8NOx1swpHoSJVCPJ5xn7dh6vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit 98898ee43a94375cf814b86fb7f485c39fb2c072:

  ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-14 20:56:09 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/new-atlas7mach-for-3.20

for you to fetch changes up to 031a1a58513801a319f45f6ac1233605b13aefd2:

  ARM: sirf: add Atlas7 machine support (2015-01-14 21:09:24 +0800)

----------------------------------------------------------------
drop CSR Marco machine and add Atlas7 new machine

This is the init support for CSR Atlas7 new SoC. Old Marco has never
shipped to customers and been dropped.

----------------------------------------------------------------
Barry Song (3):
      ARM: sirf: drop Marco support in reset controller module
      ARM: sirf: drop Marco machine
      ARM: sirf: move to debug_ll_io_init and drop map_io

Zhiwu Song (2):
      ARM: sirf: move platsmp to support Atlas7 SoC
      ARM: sirf: add Atlas7 machine support

 arch/arm/mach-prima2/Kconfig    |   22 +++++++++--------
 arch/arm/mach-prima2/Makefile   |    1 -
 arch/arm/mach-prima2/common.c   |   22 ++++-------------
 arch/arm/mach-prima2/lluart.c   |   33 -------------------------
 arch/arm/mach-prima2/platsmp.c  |   52 ++++++++++-----------------------------
 arch/arm/mach-prima2/rstc.c     |   41 +++++++++---------------------
 arch/arm/mach-prima2/rtciobrg.c |    1 -
 7 files changed, 42 insertions(+), 130 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/lluart.c

-barry
