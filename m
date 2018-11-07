From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed,  7 Nov 2018 09:40:04 +0000
Subject: [RFC PATCH 0/4] Minor improvements over handling dependency on GAS
Message-ID: <1541583608-26375-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent changes in Kconfig processing it is now possible to expose
dependency on specific tools and supported options via Kconfig rather
than bury it deep in Makefile.

This small series try to address the case where the whole feature, for
instance arm64/lse or arm/crypto, depends on GAS.

Vladimir Murzin (4):
  kconfig: add as-instr macro to scripts/Kconfig.include
  arm64: lse: expose dependency on gas via Kconfig
  arm64: turn "broken gas inst" into real config option
  ARM: crypto: expose dependency on gas via Kconfig

 arch/arm/crypto/Kconfig         | 31 +++++++++++++++++++++----------
 arch/arm/crypto/Makefile        | 31 ++++++-------------------------
 arch/arm64/Kconfig              |  4 ++++
 arch/arm64/Makefile             | 18 ++----------------
 arch/arm64/include/asm/atomic.h |  2 +-
 arch/arm64/include/asm/lse.h    |  6 +++---
 arch/arm64/kernel/cpufeature.c  |  4 ++--
 scripts/Kconfig.include         |  4 ++++
 8 files changed, 43 insertions(+), 57 deletions(-)

-- 
1.9.1
