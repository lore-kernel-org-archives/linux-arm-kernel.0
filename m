From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Sep 2017 07:52:17 -0700
Subject: [PATCH 0/2] Fix preemption issues with kvm_arm_get_running_vcpu
Message-ID: <1504882339-42520-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

These two patches slightly improves our preemption configuration when
accessing the per-CPU variables holding the currently running VCPU by
removing a redundant check and rearranging calling code from
non-preemptible context on RT systems.

I'm not entirely sure if we fix issues only affecting PREEMPT_RT in mainline
and also cc these to stable.  Looking at the git log there seems to be some
precedence for this.  If not, I'm happy to remove the cc tag and/or drop the
second patch.

Thanks,
-Christoffer

Christoffer Dall (2):
  KVM: arm/arm64: Remove redundant preemptible checks
  KVM: arm/arm64: Fix vgic_mmio_change_active with PREEMPT_RT

 virt/kvm/arm/arm.c            |  2 --
 virt/kvm/arm/vgic/vgic-mmio.c | 12 +++++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.7.4
