From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 8 Mar 2017 12:09:38 +0800
Subject: [PATCH v2 0/3] arm64: acpi: apei: handle SEI notification type for
 ARMv8
Message-ID: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM APEI extension proposal added SEI (asynchronous SError interrupt)
notification type for ARMv8.

Add a new GHES error source handling function for SEI. In firmware
first mode, if an error source's notification type is SEI. Then GHES
could parse and report the detail error information.

This series is based on Tyler's series "[PATCH V12 00/10] Add UEFI 2.6 and ACPI 6.1 updates
for RAS on ARM64" and the latest mainline.

v2: add kvm guest SEI notification support
    add nmi_{entry, exit} to protect ghes_notify_sei

Xie XiuQi (3):
  arm64: RAS: add ras extension runtime detection
  acpi: apei: handle SEI notification type for ARMv8
  arm64: KVM: add guest SEI support

 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/sysreg.h      |  2 ++
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/cpufeature.c       | 11 +++++++
 arch/arm64/kernel/traps.c            | 31 +++++++++++++++++++
 arch/arm64/kvm/handle_exit.c         | 22 ++++++++++++--
 drivers/acpi/apei/Kconfig            | 14 +++++++++
 drivers/acpi/apei/ghes.c             | 58 +++++++++++++++++++++++++++++++++++-
 include/acpi/ghes.h                  |  1 +
 9 files changed, 139 insertions(+), 4 deletions(-)

-- 
1.8.3.1
