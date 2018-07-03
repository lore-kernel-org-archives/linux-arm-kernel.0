From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  3 Jul 2018 10:21:58 +0900
Subject: [PATCH 0/3] arm, arm64,
 microblaze: add endianness options to LDFLAGS instead of LD
Message-ID: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


We are able to evaluate compiler / toolchain capability in the
Kconfig phase.
(If you do not know the background of this work, please read
 the commit log of 316d55d55f49eca442e4fd948f5fa92bab0c8312)

To achieve this, 'CC', 'LD', etc. must be passed to Kconfig.

arch/*/Makefile should not tweak such environment variables
depending on CONFIG options - this would cause circular dependency.
  - We want to pass $(LD) from Makefile to Kconfig
  - CONFIG_CPU_BIG_ENDIAN is defined by Kconfig, then given
    back to Makefile

Nicholas already fixed this issue for PowerPC in commit 1421dc6d48296a.

I need to fix arm, arm64, microblaze as well
before I start moving linker option tests to Kconfig from Makefile.

arch maintainers:
Please pick up a proper patch for your tree.



Masahiro Yamada (3):
  ARM: add endianness option to LDFLAGS instead of LD
  arm64: add endianness option to LDFLAGS instead of LD
  microblaze: add endianness options to LDFLAGS instead of LD

 arch/arm/Makefile        | 4 ++--
 arch/arm64/Makefile      | 6 ++----
 arch/microblaze/Makefile | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.7.4
