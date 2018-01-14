From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 14 Jan 2018 16:41:15 +0000
Subject: [PATCH v2 0/3] sha3 fixes and new implementation for arm64
Message-ID: <20180114164118.18330-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an implementation of SHA3 to arm64 using the new special instructions,
and another one using scalar instructions but coded in assembler (#2)

In preparation of that, fix a bug in the SHA3 (#1) and add some new test
vectors to get better test coverage (#3).

v2: Drop generic SHA3 as a fallback for the arm64 module. Instead, provide
    a special arm64 version to use as a fallback when the instructions are
    not available or when executing in a context that does not allow SIMD

    Drop patches that simplify the generic SHA3 and make it reusable by
    other modules.

Ard Biesheuvel (3):
  crypto/generic: sha3 - fixes for alignment and big endian operation
  crypto/arm64: sha3 - new scalar + v8.2 Crypto Extensions
    implementation
  crypto/testmgr: sha3 - add new testcases

 arch/arm64/crypto/Kconfig           |   4 +
 arch/arm64/crypto/Makefile          |   3 +
 arch/arm64/crypto/sha3-arm64-core.S | 512 ++++++++++++++++++
 arch/arm64/crypto/sha3-arm64-glue.c | 192 +++++++
 crypto/sha3_generic.c               |   5 +-
 crypto/testmgr.h                    | 550 ++++++++++++++++++++
 6 files changed, 1264 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/crypto/sha3-arm64-core.S
 create mode 100644 arch/arm64/crypto/sha3-arm64-glue.c

-- 
2.11.0
