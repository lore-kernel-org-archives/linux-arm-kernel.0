From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 05 Oct 2015 19:33:12 -0700
Subject: [PATCH v2 0/2] KVM/arm64: add fp/simd lazy switch support
Message-ID: <1444098794-19244-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a followup to the armv7 fp/simd lazy switch
implementation, uses similar approach and depends on the series -
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-September/016567.html
Patches are based on 4.3-rc2 commit 1f93e4a96c91093

Patches are based on earlier arm64 fp/simd optimization work -
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015748.html

And subsequent fixes by Marc and Christoffer at KVM Forum hackathon to handle
32-bit guest on 64 bit host - 
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-August/016128.html

The patch series have been tested on Foundation Model arm64/arm64 and
arm32/arm64. The test program used can be found here 

https://github.com/mjsmar/arm-arm64-fpsimd-test

Launched upto 16 instances on 4-way Guest and another 16 on the host (both 
cases 1mS sleep), ran overnight. 

Changes v1->v2:
- Tested arm32/arm64
- rebased to 4.3-rc2
- changed a couple register accesses from 64 to 32 bit 

Mario Smarduch (2):
  add hooks for armv8 fp/simd lazy switch
  enable armv8 fp/simd lazy switch

 arch/arm/kvm/arm.c                |  2 --
 arch/arm64/include/asm/kvm_asm.h  |  1 +
 arch/arm64/include/asm/kvm_host.h |  3 ++
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kvm/hyp.S              | 59 ++++++++++++++++++++++++++-------------
 5 files changed, 45 insertions(+), 21 deletions(-)

-- 
1.9.1
