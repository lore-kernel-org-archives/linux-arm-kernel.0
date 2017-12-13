From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:02 +0000
Subject: [RFC PATCH 0/5]  Introduce PMSAv8 memory protection unit
Message-ID: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is an attempt to add support for PMSAv8 MPU defined by
ARMv8R/M architecture.

I'm have a doubt about adding dedicated config option, so both v7 and
v8 versions of PMSA are covered with CONFIG_MPU, but I'd glad to hear
what people think of it.

Thanks!

Vladimir Murzin (5):
  ARM: NOMMU: Move PMSAv7 MPU under it's own namespace
  ARM: NOMMU: Reorganise __setup_mpu
  ARM: NOMMU: Postpone MPU activation till __after_proc_init
  ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment restrictions
  ARM: NOMMU: Support PMSAv8 MPU

 arch/arm/include/asm/mpu.h    | 112 ++++++++++-----
 arch/arm/include/asm/v7m.h    |  14 +-
 arch/arm/kernel/asm-offsets.c |   8 +-
 arch/arm/kernel/head-nommu.S  | 260 +++++++++++++++++++++++++++--------
 arch/arm/kernel/vmlinux.lds.S |   8 ++
 arch/arm/mm/Makefile          |   2 +-
 arch/arm/mm/nommu.c           |  32 +++++
 arch/arm/mm/pmsa-v7.c         |  59 ++++----
 arch/arm/mm/pmsa-v8.c         | 307 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 668 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/mm/pmsa-v8.c

-- 
2.0.0
