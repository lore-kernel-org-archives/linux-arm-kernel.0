From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 26 Sep 2016 10:52:26 +1000
Subject: [PATCH 0/4] arm/versatile: no-MMU support
Message-ID: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches support configuring and building the versatile
machine with a no-MMU kernel.

There is only a minor few changes required. It was previously possible
in older kernels to build for versatile with CONFIG_MMU disabled, but
the change to devicetree lost that capability. These changes make it
possible again.

One patch is a fix for address translation (broken on older kernels too),
two are build problems when CONFIG_MMU is disabled, and the last is the
actuall configuration changes needed.

The motivation for this is that the versatile machine is well supported
in qemu. And this provides an excellent platform for development and
testing no-MMU support on ARM in general. With these patches applied
it is possible to build and run a kernel with MMU disabled on qemu.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/Kconfig                       |   10 ++++++++++
 arch/arm/Kconfig.debug                 |    3 ++-
 arch/arm/include/asm/mach/map.h        |    1 +
 arch/arm/mach-versatile/Kconfig        |    3 ++-
 arch/arm/mach-versatile/Makefile.boot  |    3 +++
 arch/arm/mach-versatile/versatile_dt.c |    4 ++++
 6 files changed, 22 insertions(+), 2 deletions(-)
