From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Jul 2018 19:01:21 +0100
Subject: [PATCH 0/2] arm64: spectre-v1 write fixes (CVE-2018-3693)
Message-ID: <20180710180123.56461-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches inhibit spectre-v1-write gadgets found in arch/arm64, using the
same mitigation applied to existing spectre-v1-read gadgets.

This issue is also known as CVE-2018-3693, or "bounds check bypass store".
More details can be found in the Arm Cache Speculation Side-channels
whitepaper, available from the Arm security updates site [1].

Thanks,
Mark.

[1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability

Mark Rutland (2):
  arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()
  KVM: arm/arm64: vgic: fix possible spectre-v1 write in
    vgic_mmio_write_apr()

 arch/arm64/kernel/ptrace.c       | 19 +++++++++++--------
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  3 +++
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.11.0
