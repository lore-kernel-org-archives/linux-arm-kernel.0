From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 13:41:56 +0200
Subject: [GIT PULL] Allwinner core changes for 4.18
Message-ID: <20180521114156.6nppm5vomksxpeqv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is our mach-sunxi changes for the next merge window, thanks!
Maxime

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-core-for-4.18

for you to fetch changes up to 6961275e72a8c15cc4ebf108a81eee758480a6a2:

  ARM: sun8i: smp: Add support for A83T (2018-05-08 15:00:20 +0200)

----------------------------------------------------------------
Allwinner core changes for 4.18

The A83t, unlike the other Allwinner SoCs, cannot use PSCI because of a
silicon bug. As such, we needed to have some smp_ops in order to bringup
the various cores (and clusters) found on this SoC.

----------------------------------------------------------------
Doug Berger (1):
      ARM: Allow this header to be included by assembly files

Myl?ne Josserand (7):
      ARM: sunxi: smp: Move assembly code into a file
      ARM: smp: Add initialization of CNTVOFF
      ARM: sunxi: Add initialization of CNTVOFF
      ARM: shmobile: Convert file to use cntvoff
      ARM: sun9i: smp: Rename clusters's power-off
      ARM: sun9i: smp: Add is_a83t field
      ARM: sun8i: smp: Add support for A83T

 arch/arm/common/Makefile                 |   1 +
 arch/arm/common/secure_cntvoff.S         |  32 +++++
 arch/arm/include/asm/cputype.h           |  10 +-
 arch/arm/include/asm/secure_cntvoff.h    |   8 ++
 arch/arm/mach-shmobile/common.h          |   1 -
 arch/arm/mach-shmobile/headsmp-apmu.S    |  22 +--
 arch/arm/mach-shmobile/setup-rcar-gen2.c |   3 +-
 arch/arm/mach-sunxi/Kconfig              |   2 +-
 arch/arm/mach-sunxi/Makefile             |   2 +-
 arch/arm/mach-sunxi/headsmp.S            |  81 +++++++++++
 arch/arm/mach-sunxi/mc_smp.c             | 239 +++++++++++++++++++------------
 arch/arm/mach-sunxi/sunxi.c              |  20 ++-
 12 files changed, 298 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/common/secure_cntvoff.S
 create mode 100644 arch/arm/include/asm/secure_cntvoff.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/e565b6d5/attachment.sig>
