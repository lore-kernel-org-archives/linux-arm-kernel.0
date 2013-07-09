From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Jul 2013 15:16:03 +0100
Subject: [PATCH 0/3] arm/arm64: a trio of boot mode detection fixes
Message-ID: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix a couple of issues in the boot mode detection
code where in the case of mismatched boot modes we can corrupt a small
portion of memory or fail to detect the fact we've booted CPUs with
mismatched modes due to the boot mode being logged incoherently.

Thanks,
Mark.

Mark Rutland (3):
  arm: hyp: fix macro parameterisation
  arm: virt: ensure visibility of __boot_cpu_mode
  arm64: virt: ensure visibility of __boot_cpu_mode

 arch/arm/include/asm/virt.h   | 12 ++++++++++++
 arch/arm/kernel/hyp-stub.S    |  4 ++--
 arch/arm/kernel/setup.c       |  2 ++
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.8.1.1
