From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  9 Jan 2017 19:57:27 +0000
Subject: [RFC PATCH 0/2] ARM: kernel mode NEON in softirq context
Message-ID: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch #1 in this series adds support for using the NEON in kernel mode
while executing in softirq context. By allowing this, subsystems that
perform non-trivial crypto in softirq context (such as CCMP in the
mac80211 layer) can use algorithms such as the AES-CCM driver in
patch #2, which is 13x faster than the generic CCM driver.

Ard Biesheuvel (2):
  ARM: vfp - allow kernel mode NEON in softirq context
  crypto: arm/aes - add CCM driver using ARMv8 Crypto Extensions

 arch/arm/crypto/Kconfig           |   8 +
 arch/arm/crypto/Makefile          |   2 +
 arch/arm/crypto/aes-ce-ccm-core.S | 234 +++++++++++++
 arch/arm/crypto/aes-ce-ccm-glue.c | 360 ++++++++++++++++++++
 arch/arm/vfp/vfpmodule.c          |  22 +-
 5 files changed, 620 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/crypto/aes-ce-ccm-core.S
 create mode 100644 arch/arm/crypto/aes-ce-ccm-glue.c

-- 
2.7.4
