From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Dec 2016 18:42:22 +0000
Subject: [PATCH v3 0/6] crypto: ARM/arm64 CRC-T10DIF/CRC32/CRC32C roundup
Message-ID: <1480963348-24203-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v3 combines the CRC-T10DIF and CRC32 implementations for both ARM and
arm64 that I sent out a couple of weeks ago, and adds support to the latter
for CRC32C.

Changes since v2:
- fix a couple of big-endian bugs in CRC32/CRC32C
- add back handling to the CRC-T10DIF routines of buffers that are not a
  multiple of 16 bytes (but they still must be 16 byte aligned)

Ard Biesheuvel (6):
  crypto: testmgr - avoid overlap in chunked tests
  crypto: testmgr - add/enhance test cases for CRC-T10DIF
  crypto: arm64/crct10dif - port x86 SSE implementation to arm64
  crypto: arm/crct10dif - port x86 SSE implementation to ARM
  crypto: arm64/crc32 - accelerated support based on x86 SSE
    implementation
  crypto: arm/crc32 - accelerated support based on x86 SSE
    implementation

 arch/arm/crypto/Kconfig               |  10 +
 arch/arm/crypto/Makefile              |   4 +
 arch/arm/crypto/crc32-ce-core.S       | 306 ++++++++++++++
 arch/arm/crypto/crc32-ce-glue.c       | 242 +++++++++++
 arch/arm/crypto/crct10dif-ce-core.S   | 427 ++++++++++++++++++++
 arch/arm/crypto/crct10dif-ce-glue.c   | 101 +++++
 arch/arm64/crypto/Kconfig             |  11 +
 arch/arm64/crypto/Makefile            |   6 +
 arch/arm64/crypto/crc32-ce-core.S     | 266 ++++++++++++
 arch/arm64/crypto/crc32-ce-glue.c     | 212 ++++++++++
 arch/arm64/crypto/crct10dif-ce-core.S | 392 ++++++++++++++++++
 arch/arm64/crypto/crct10dif-ce-glue.c |  95 +++++
 crypto/testmgr.c                      |   2 +-
 crypto/testmgr.h                      |  70 ++--
 14 files changed, 2115 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/crypto/crc32-ce-core.S
 create mode 100644 arch/arm/crypto/crc32-ce-glue.c
 create mode 100644 arch/arm/crypto/crct10dif-ce-core.S
 create mode 100644 arch/arm/crypto/crct10dif-ce-glue.c
 create mode 100644 arch/arm64/crypto/crc32-ce-core.S
 create mode 100644 arch/arm64/crypto/crc32-ce-glue.c
 create mode 100644 arch/arm64/crypto/crct10dif-ce-core.S
 create mode 100644 arch/arm64/crypto/crct10dif-ce-glue.c

-- 
2.7.4
