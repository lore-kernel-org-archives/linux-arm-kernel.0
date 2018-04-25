From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Apr 2018 17:13:39 +0100
Subject: [PATCH 0/3] arm64/kvm spectre-v1 fixes
Message-ID: <20180425161342.38133-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix arm64-specific potential spectre-v1 gadgets found by
smatch when run over v4.17-rc2.

I'm still building up my smatch database, so it's possible that there are
further gadgets to be found.

For the moment I've ignored issues which appear to be cross-architecture.

Thanks,
Mark.

Mark Rutland (3):
  arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
  KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()
  KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()

 arch/arm64/kernel/ptrace.c       | 14 ++++++++++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  5 +++++
 virt/kvm/arm/vgic/vgic.c         | 14 ++++++++++----
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.11.0
