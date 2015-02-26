From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 15:29:04 +0000
Subject: [RFC PATCH 0/3] arm64: KVM: use increased VA range if needed
Message-ID: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series addresses the issue where KVM will not be able to initialize
when running on a system whose RAM is located higher in the physical address
space than can be covered with an ID map using VA_BITS of virtual address
space.

Tested on AMD Seattle with 4k pages/VA_BITS==39.

Ard Biesheuvel (3):
  ARM, arm64: kvm: get rid of the bounce page
  arm64: make ID map shareable with EL2
  arm64: KVM: use ID map with increased VA range if required

 arch/arm/kernel/vmlinux.lds.S   | 12 +++++++++---
 arch/arm/kvm/init.S             | 11 +++++++++++
 arch/arm/kvm/mmu.c              | 42 +++++------------------------------------
 arch/arm64/kernel/head.S        | 22 +++++++++++++++++----
 arch/arm64/kernel/vmlinux.lds.S | 20 +++++++++++++-------
 arch/arm64/kvm/hyp-init.S       | 40 +++++++++++++++++++++++++++++++++++++--
 6 files changed, 94 insertions(+), 53 deletions(-)

-- 
1.8.3.2
