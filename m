From: sdu.liu@huawei.com (Liu Hua)
Date: Thu, 27 Mar 2014 16:00:37 +0800
Subject: [PATCH 0/3] add LPAE support for kexec and kernel
Message-ID: <1395907240-13308-1-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series introduce LPAE support for user space
utility kexec(the last) and ARM linux kernel(the others).

I have tested the patch series in armA15 platform which have
more than 4G memory.

Liu Hua (2):
  ARM : kdump : Add LPAE support
  ARM : kdump : add arch_crash_save_vmcoreinfo

 arch/arm/include/asm/elf.h      |  4 +++-
 arch/arm/kernel/elf.c           | 33 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c |  7 +++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

Liu Hua (1):
  kexec: ARM: add LPAE support

 kexec/arch/arm/crashdump-arm.c | 23 ++++++++++++++++++++---
 kexec/kexec-iomem.c            |  8 ++++----
 kexec/kexec.h                  |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
1.9.0
