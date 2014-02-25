From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Feb 2014 13:38:56 +0100
Subject: [PATCH resend 0/3] arm64: 32-bit compat hwcaps for Crypto Extensions
Message-ID: <1393331939-31289-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell has kindly merged the ARM side of this series, the patches below are
what remains to enable HWCAP2 support for ARM binaries running under an arm64
kernel.

Ard Biesheuvel (3):
  binfmt_elf: add ELF_HWCAP2 to compat auxv entries
  arm64: add AT_HWCAP2 support for 32-bit compat
  arm64: advertise ARMv8 extensions to 32-bit compat ELF binaries

 arch/arm64/include/asm/hwcap.h |  9 ++++++++-
 arch/arm64/kernel/setup.c      | 33 +++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c         |  5 +++++
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.3.2
