From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 23:18:50 +0100
Subject: [GIT PULL] Allwinner core changes for 3.14
Message-ID: <20131220221850.GA23269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 8f1ae77f466660b6da2455cccecc07ae631fa66d:

  reset: Add Allwinner SoCs Reset Controller Driver (2013-11-22 21:20:36 +0100)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.14

for you to fetch changes up to 73346794b48237b7b4c2a5c02b12e3c4f1da7551:

  ARM: sun6i: Add SMP support for the Allwinner A31 (2013-12-16 21:33:41 +0100)

----------------------------------------------------------------
Allwinner core changes for 3.14

This mostly adds the reset controller initialisation for the A31 and the SMP
operations for this SoC.

----------------------------------------------------------------
Baruch Siach (1):
      dt-bindings: fix example of allwinner interrupt controller

Maxime Ripard (4):
      Merge branch 'sunxi/drivers-for-3.14' into sunxi/core-for-3.14
      ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER
      ARM: sunxi: Register the A31 reset IP in init_time
      ARM: sun6i: Add SMP support for the Allwinner A31

 .../interrupt-controller/allwinner,sun4i-ic.txt    |   2 +-
 arch/arm/mach-sunxi/Kconfig                        |   1 +
 arch/arm/mach-sunxi/Makefile                       |   1 +
 arch/arm/mach-sunxi/common.h                       |  19 ++++
 arch/arm/mach-sunxi/headsmp.S                      |   9 ++
 arch/arm/mach-sunxi/platsmp.c                      | 124 +++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c                        |  14 +++
 7 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-sunxi/common.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/7d2359cd/attachment.sig>
