From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 21 May 2017 10:23:35 +0000
Subject: [PATCH 0/5] crypto: arm - enable module autoloading
Message-ID: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the prerequisite changes are in place, we can modify the
various accelerated crypto modules that use special instructions to
expose the CPU feature they depend on. This allows udev to autoload
the module at boot.

Ard Biesheuvel (5):
  crypto: arm/aes-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/ghash-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/sha1-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/sha2-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/crc32 - enable module autoloading based on CPU feature
    bits

 arch/arm/crypto/aes-ce-glue.c   | 6 ++----
 arch/arm/crypto/crc32-ce-glue.c | 6 ++++++
 arch/arm/crypto/ghash-ce-glue.c | 6 ++----
 arch/arm/crypto/sha1-ce-glue.c  | 5 ++---
 arch/arm/crypto/sha2-ce-glue.c  | 5 ++---
 5 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.7.4
