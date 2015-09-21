From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 21 Sep 2015 14:26:21 -0700
Subject: [RFT - PATCH 0/2] KVM/arm64: add fp/simd lazy switch support
Message-ID: <1442870783-30752-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a followup to the armv7 fp/simd lazy switch 
implementation, uses similar approach and depends on the series - see
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-September/016516.html

It's based on earlier arm64 fp/simd optimization work - see
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015748.html

And subsequent fixes by Marc and Christoffer at KVM Forum hackathon to handle
32-bit guest on 64 bit host - see
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-August/016128.html

This series has be tested on arm64/arm64 but not arm32/arm64 which needs
validation (the RFT tag). The results substantially decrease the numbe of
fp/simd context switches for a FP load. 

At this time I don't have arm32/arm64 working and requesting Christoffer and/or 
Marc to test 32 bit guest on 64 bit host.

Mario Smarduch (2):
  add hooks for armv8 fp/simd lazy switch support
  enable armv8 fp/simd lazy switch

 arch/arm/kvm/arm.c                |  2 --
 arch/arm64/include/asm/kvm_asm.h  |  1 +
 arch/arm64/include/asm/kvm_host.h |  3 ++
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kvm/hyp.S              | 59 ++++++++++++++++++++++++++-------------
 5 files changed, 45 insertions(+), 21 deletions(-)

-- 
1.9.1
