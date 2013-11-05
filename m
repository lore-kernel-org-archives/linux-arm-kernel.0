From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Nov 2013 18:58:13 +0000
Subject: [PATCH v3 0/2] arm/arm64: KVM: BE guest support
Message-ID: <1383677895-3728-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a slightly extended series about supporting BE guests.
The first patch is the usual MMIO thing, unchanged from v2.
The second one fixes PSCI to sample the endianness of the caller on
CPU_ON, and propagate that endianness to the incoming CPU.

Marc Zyngier (2):
  arm/arm64: KVM: MMIO support for BE guest
  arm/arm64: KVM: propagate caller endianness to the incomming vcpu

 arch/arm/include/asm/kvm_emulate.h   | 46 +++++++++++++++++++
 arch/arm/kvm/mmio.c                  | 87 +++++++++++++++++++++++++++++++-----
 arch/arm/kvm/psci.c                  |  4 ++
 arch/arm64/include/asm/kvm_emulate.h | 56 +++++++++++++++++++++++
 4 files changed, 182 insertions(+), 11 deletions(-)

-- 
1.8.2.3
