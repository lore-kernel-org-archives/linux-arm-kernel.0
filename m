From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Dec 2017 15:16:54 +0100
Subject: [PATCH 0/2] KVM: arm/arm64: Fix two problems with the arch timer
 introduced in v4.15-rc1
Message-ID: <20171215141656.25815-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch solves the problem with the spurious IRQ (which is not a
problem at all and just an artifact of what Jia is writing about), and
it solves the issue of accidentally overwriting the in-memory copy of
the guest state with a disabled timer, leaving the VCPU in the weeds.

The second patch addresses addresses an issue identified when booting
with kvmtool  The reason why we didn't see it with QEMU is that QEMU is
so happy to signal its threads in the initial setup phase, that it hides
the bug.

Jia, I'd appreciate your tested-by after having applied both patches on
your platform.

Thanks,
-Christoffer

Christoffer Dall (2):
  KVM: arm/arm64: Properly handle arch-timer IRQs after
    vtimer_save_state
  KVM: arm/arm64: Fix timer enable flow

 virt/kvm/arm/arch_timer.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.14.2
