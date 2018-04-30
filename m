From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Apr 2018 18:18:20 +0200
Subject: [PATCH resend 00/10] crypto: arm64 - play nice with CONFIG_PREEMPT
Message-ID: <20180430161830.14892-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Herbert,

These are the patches that depend on the arm64/assembler.h patches that
inadvertently got pulled into the cryptodev tree and reverted shortly
after. Those have now been merged into Linus's tree, and so the
remaining changes can be applied as well. Please apply.

Ard Biesheuvel (10):
  crypto: arm64/sha1-ce - yield NEON after every block of input
  crypto: arm64/sha2-ce - yield NEON after every block of input
  crypto: arm64/aes-ccm - yield NEON after every block of input
  crypto: arm64/aes-blk - yield NEON after every block of input
  crypto: arm64/aes-bs - yield NEON after every block of input
  crypto: arm64/aes-ghash - yield NEON after every block of input
  crypto: arm64/crc32-ce - yield NEON after every block of input
  crypto: arm64/crct10dif-ce - yield NEON after every block of input
  crypto: arm64/sha3-ce - yield NEON after every block of input
  crypto: arm64/sha512-ce - yield NEON after every block of input

 arch/arm64/crypto/aes-ce-ccm-core.S   | 150 +++++----
 arch/arm64/crypto/aes-ce.S            |  15 +-
 arch/arm64/crypto/aes-modes.S         | 331 ++++++++++++--------
 arch/arm64/crypto/aes-neonbs-core.S   | 305 ++++++++++--------
 arch/arm64/crypto/crc32-ce-core.S     |  40 ++-
 arch/arm64/crypto/crct10dif-ce-core.S |  32 +-
 arch/arm64/crypto/ghash-ce-core.S     | 113 +++++--
 arch/arm64/crypto/ghash-ce-glue.c     |  28 +-
 arch/arm64/crypto/sha1-ce-core.S      |  42 ++-
 arch/arm64/crypto/sha2-ce-core.S      |  37 ++-
 arch/arm64/crypto/sha3-ce-core.S      |  77 +++--
 arch/arm64/crypto/sha512-ce-core.S    |  27 +-
 12 files changed, 762 insertions(+), 435 deletions(-)

-- 
2.17.0
