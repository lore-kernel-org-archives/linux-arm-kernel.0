From: jinb.park7@gmail.com (Jinbum Park)
Date: Wed, 28 Feb 2018 23:29:09 +0900
Subject: [kernel-hardening] [PATCH 0/2] arm: Add ARCH_HAS_FORTIFY_SOURCE
Message-ID: <20180228142909.GA3113@pjb1027-Latitude-E5410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series are to select ARCH_HAS_FORTIFY_SOUCE on arm.
A lot of architectures already select ARCH_HAS_FORTIFY_SOURCE
to support CONFIG_FORTIFY_SOURCE that detects overflows at compile-time.
(6974f0c4555e ("include/linux/string.h:
add the option of fortified string.h functions)
ARM can be built and run with CONFIG_FORTIFY_SOURCE.

Additionally, modify vdso.c to remove compile-error that happens
when built arm kernel with CONFIG_FORTIFY_SOURCE.

Jinbum Park (2):
  arm: mm: Define vdso_start, vdso_end as array
  arm: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE

 arch/arm/Kconfig            |  1 +
 arch/arm/include/asm/vdso.h |  2 --
 arch/arm/kernel/vdso.c      | 12 +++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.9.1
