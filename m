From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 16:47:22 +0100
Subject: [PATCH v2 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17
Message-ID: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains fixes for some issues observed since the KVM arm64
pull request for 4.17.

It supersedes the previous v1 [1].

The first patch (from Mark Rutland) adds a straightforward helper to
modify particular bits in a system register conditionally.  This is used
by patch 3 (though obviously it could be coded round and patch 1
dropped, if preferred).

See other patches for details of the individual fixes and changes from
the previous posting.

[1] [PATCH 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584107.html

Dave Martin (3):
  KVM: arm64: Don't mask softirq with IRQs disabled in vcpu_put()
  KVM: arm64/sve: Fix SVE trap restoration for non-current tasks
  KVM: arm64: Avoid mistaken attempts to save SVE state for vcpus

Mark Rutland (1):
  arm64: introduce sysreg_clear_set()

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/sysreg.h   | 11 +++++++++++
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++---------
 3 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.1.4
