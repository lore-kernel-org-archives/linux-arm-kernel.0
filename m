From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 17:05:54 +0100
Subject: [PATCH 0/2] arm{,64}/kvm: excise redundant cache maintenance
Message-ID: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in a jailhouse thread a short while ago [1,2], the presence of the
virtualization extensions implies that page table walks are coherent, and do
not require that updates are cleaned to the PoU.

These patches remove the redundant maintenance and related infrastructure.

As I do not have a suitably configured ARMv7 board, I have not been able to
test the patches myself, and any testing would be appreciated.

Thanks,
Mark.

[1] https://groups.google.com/d/msg/jailhouse-dev/c9Ier7mUNoI/JWUJGyxfAQAJ
[2] https://groups.google.com/d/msg/jailhouse-dev/c9Ier7mUNoI/qagpektgAQAJ

Mark Rutland (2):
  arm/kvm: excise redundant cache maintenance
  arm64/kvm: remove unused stub functions

 arch/arm/include/asm/kvm_mmu.h   | 28 ++--------------------------
 arch/arm/kvm/mmu.c               |  2 --
 arch/arm64/include/asm/kvm_mmu.h |  6 ------
 3 files changed, 2 insertions(+), 34 deletions(-)

-- 
1.9.1
