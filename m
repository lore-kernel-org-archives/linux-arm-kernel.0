From: panand@redhat.com (Pratyush Anand)
Date: Tue, 22 Nov 2016 10:02:42 +0530
Subject: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
Message-ID: <cover.1479788404.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
is around 13MB and initramfs is around 30MB. It takes more than 20 second
even when we have -O2 optimization enabled. However, if dcache is enabled
during purgatory execution then, it takes just a second in SHA verification.

Therefore, these patches adds support for dcache enabling facility during
purgatory execution. There is no change in kexec behaviour by default.
Dcache will be enabled only when --enable-dcache is passed to kexec.

Pratyush Anand (2):
  arm64: Add enable/disable d-cache support for purgatory
  arm64: Pass RAM boundary and enable-dcache flag to purgatory

 kexec/arch/arm64/include/arch/options.h |   6 +-
 kexec/arch/arm64/include/types.h        |  16 ++
 kexec/arch/arm64/kexec-arm64.c          |  25 ++-
 purgatory/arch/arm64/Makefile           |   2 +
 purgatory/arch/arm64/cache-asm.S        | 186 ++++++++++++++++++
 purgatory/arch/arm64/cache.c            | 330 ++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/cache.h            |  79 ++++++++
 purgatory/arch/arm64/purgatory-arm64.c  |  11 ++
 8 files changed, 653 insertions(+), 2 deletions(-)
 create mode 100644 kexec/arch/arm64/include/types.h
 create mode 100644 purgatory/arch/arm64/cache-asm.S
 create mode 100644 purgatory/arch/arm64/cache.c
 create mode 100644 purgatory/arch/arm64/cache.h

-- 
2.7.4
