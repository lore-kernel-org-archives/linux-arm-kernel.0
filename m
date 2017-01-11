From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 17:01:53 +0000
Subject: [PATCH v2 0/5] ARM: add module autoloading support for crypto modules
Message-ID: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series wires up the crypto modules that use the ARM 32-bit versions of
the ARMv8 Crypto Extensions to udev autoloading, by exposing the HWCAP2
feature bits via the CPU modalias. This is very similar to the arm64
implementation, with the notable exception that ARM has its CPU feature
definitions split across HWCAP and HWCAP2.

Given that the crypto feature bits are all exposed via HWCAP2, and considering
that there are currently no features exposed via HWCAP that are relevant to
udev module autoloading, exposing HWCAP2 only should be sufficient, at least
for now.

Changes since v1:
- rebase onto v4.10-rc2

Ard Biesheuvel (5):
  ARM: wire up HWCAP2 feature bits to the CPU modalias
  crypto: arm/aes-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/ghash-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/sha1-ce - enable module autoloading based on CPU feature
    bits
  crypto: arm/sha2-ce - enable module autoloading based on CPU feature
    bits

 arch/arm/Kconfig                  |  1 +
 arch/arm/crypto/aes-ce-glue.c     |  6 ++--
 arch/arm/crypto/ghash-ce-glue.c   |  6 ++--
 arch/arm/crypto/sha1-ce-glue.c    |  5 ++-
 arch/arm/crypto/sha2-ce-glue.c    |  5 ++-
 arch/arm/include/asm/cpufeature.h | 32 ++++++++++++++++++++
 6 files changed, 41 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/include/asm/cpufeature.h

-- 
2.7.4
