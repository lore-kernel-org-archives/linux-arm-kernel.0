From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  1 Dec 2017 15:19:39 +0000
Subject: [PATCH 0/3] arm64: SVE fixes for v4.15-rc1
Message-ID: <1512141582-17474-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mini-series contains a few fixes for known issues in the arm64 SVE
patches that missed the merge window.

They should be considered fixes for v4.15.

Dave Martin (3):
  arm64: KVM: Move CPU ID reg trap setup off the world switch path
  arm64: fpsimd: Abstract out binding of task's fpsimd context to the
    cpu.
  arm64/sve: KVM: Avoid dereference of dead task during guest entry

 arch/arm64/include/asm/kvm_emulate.h |  8 ++++++
 arch/arm64/kernel/fpsimd.c           | 51 +++++++++++++++++++++---------------
 arch/arm64/kvm/hyp/switch.c          |  4 ---
 3 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.1.4
