From: linucherian@gmail.com (linucherian at gmail.com)
Date: Tue,  7 Mar 2017 11:22:40 +0530
Subject: [PATCH V3 0/4] KVM: arm64: Increase number of user memslots
Message-ID: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>


v2 -> v3:
- Added documentation for KVM_CAP_NR_MEMSLOTS
- Removed KVM_PRIVATE_MEM_SLOTS which is unused
- KVM_USER_MEM_SLOTS changed to 512 from 508
 
v1 -> v2:
- Enabling KVM_CAP_NR_MEMSLOTS for arm/arm64 moved to separate patch.
- Updated commit message so that what is reported to userspace is explicit.



Linu Cherian (4):
  KVM: Add documentation for KVM_CAP_NR_MEMSLOTS
  KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on arm/arm64
  KVM: arm/arm64: Remove KVM_PRIVATE_MEM_SLOTS definition that are
    unused
  KVM: arm64: Increase number of user memslots to 512

 Documentation/virtual/kvm/api.txt | 4 ++++
 arch/arm/include/asm/kvm_host.h   | 1 -
 arch/arm/kvm/arm.c                | 3 +++
 arch/arm64/include/asm/kvm_host.h | 3 +--
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
1.9.1
