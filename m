From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Feb 2018 11:19:29 +0000
Subject: [PATCH 0/4] Introduce PMSAv8 memory protection unit
Message-ID: <1518434373-27907-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This series adds support for PMSAv8 MPU defined by ARMv8R/M
architecture.

Changelog:

    RFC -> v1
        - Rebased on v4.16-rc1
	- Added Tested-by for v7M bits from Andras

Thanks!

Vladimir Murzin (4):
  ARM: NOMMU: Reorganise __setup_mpu
  ARM: NOMMU: Postpone MPU activation till __after_proc_init
  ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment restrictions
  ARM: NOMMU: Support PMSAv8 MPU

 arch/arm/include/asm/mpu.h    |  52 ++++++-
 arch/arm/include/asm/v7m.h    |   8 ++
 arch/arm/kernel/asm-offsets.c |   2 +
 arch/arm/kernel/head-nommu.S  | 180 +++++++++++++++++++++----
 arch/arm/kernel/vmlinux.lds.S |   8 ++
 arch/arm/mm/Makefile          |   2 +-
 arch/arm/mm/nommu.c           |   6 +
 arch/arm/mm/pmsa-v8.c         | 307 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 538 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mm/pmsa-v8.c

-- 
2.0.0
