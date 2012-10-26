From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 26 Oct 2012 16:51:37 +1300
Subject: [GIT PULL] Convert arch-vt8500 to multiplatform
Message-ID: <1351223497.30694.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit
ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git/ tags/armsoc-for-3.8

for you to fetch changes up to 6f35f9a9fabe8f0a89a17e353a77a7edef461bb2:

  ARM: vt8500: Convert arch-vt8500 to multiplatform (2012-10-26 16:45:19
+1300)

----------------------------------------------------------------
Two patches for 3.8 to finish converting arch-vt8500 to multiplatform.
Single arch build is maintained as we still need earlyprintk for
development work.

----------------------------------------------------------------
Tony Prisk (2):
      arm: vt8500: Convert irq.c for multiplatform integration
      ARM: vt8500: Convert arch-vt8500 to multiplatform

 arch/arm/Kconfig                                |    6 +-
 arch/arm/mach-vt8500/Kconfig                    |   12 +++
 arch/arm/mach-vt8500/common.h                   |    3 +
 arch/arm/mach-vt8500/include/mach/entry-macro.S |   26 ------
 arch/arm/mach-vt8500/include/mach/irqs.h        |   22 -----
 arch/arm/mach-vt8500/irq.c                      |  108
+++++++++++++++--------
 arch/arm/mach-vt8500/vt8500.c                   |    1 +
 7 files changed, 91 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm/mach-vt8500/Kconfig
 delete mode 100644 arch/arm/mach-vt8500/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-vt8500/include/mach/irqs.h
