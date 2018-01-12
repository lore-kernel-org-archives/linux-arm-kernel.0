From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Jan 2018 13:15:17 +0000
Subject: [PATCH 0/5] sha3 fixes and new implementation for arm64
Message-ID: <20180112131522.25663-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an implementation of SHA3 to arm64 using the new special instructions (#4)

In preparation of that, fix a bug in the SHA3 and refactor it a bit so it
can serve as a fallback for the other code. Also, add some new test vectors
to get better test coverage.

Ard Biesheuvel (5):
  crypto/generic: sha3 - fixes for alignment and big endian operation
  crypto/generic: sha3 - simplify code
  crypto/generic: sha3 - export init/update/final routines
  crypto/arm64: sha3 - new implementation based on special instructions
  crypto/testmgr: sha3 - add new testcases

 arch/arm64/crypto/Kconfig        |   6 +
 arch/arm64/crypto/Makefile       |   3 +
 arch/arm64/crypto/sha3-ce-core.S | 224 ++++++++
 arch/arm64/crypto/sha3-ce-glue.c | 156 ++++++
 crypto/sha3_generic.c            | 198 +++----
 crypto/testmgr.h                 | 550 ++++++++++++++++++++
 include/crypto/sha3.h            |   6 +-
 7 files changed, 1012 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm64/crypto/sha3-ce-core.S
 create mode 100644 arch/arm64/crypto/sha3-ce-glue.c

-- 
2.11.0
