From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 10:31:47 -0400
Subject: [PATCH v2 0/3] ARM: keystone: add ecc error interrupt handling 
Message-ID: <1435242710-31346-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for arm L1/L2 ecc and ddr3 ecc error handling
for Keystone devices

Change Log

v2: 
- removing unused and sorting headers of keystone.c are moved to a separate
  patch.
- l1l2 ecc and ddr3 ecc error handling are split it to separate patches
- removed unused headers from keystone_ecc.c
- platsmp.c removed from the patch.
- return IRQ_HANDLED for 1 bit error in l1l2 ecc handler
- checked and handled existing ecc error before enabling ddr3 interrupt
- 1 bit ddr3 interrupt is disabled, because it is handled by hardware and
  there is no reason to handle it by software

v1: initial version in one patch


Vitaly Andrianov (3):
  ARM: keystone: clean and sort keystone.c headers
  ARM: keystone: ecc: add ARM L1/L2 ecc interrupt handling
  ARM: keystone: ecc: add DDR3 ecc interrupt handling

 .../devicetree/bindings/arm/keystone/keystone.txt  |  17 +++
 arch/arm/mach-keystone/Makefile                    |   2 +-
 arch/arm/mach-keystone/keystone.c                  |  81 ++++++++++++--
 arch/arm/mach-keystone/keystone.h                  |   1 +
 arch/arm/mach-keystone/keystone_ecc.c              | 117 +++++++++++++++++++++
 5 files changed, 210 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-keystone/keystone_ecc.c

-- 
1.9.1
