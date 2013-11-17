From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 19:12:04 -0800
Subject: [PATCH 0/2 v3] arm/arm64: KVM: arch_timer save/restore
Message-ID: <1384657926-28194-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We never got around to merging any of this.  I'm sending a v2 of my
patch with Marc Zyngier's comments addressed and resending Andre's v3 of
the core timer save/restore patch.

There shouldn't be any outstanding issues here and the current patches
have been tested with the full save/restore code and works.

Andre Przywara (1):
  ARM/KVM: save and restore generic timer registers

Christoffer Dall (1):
  arm/arm64: KVM: arch_timer: Initialize cntvoff at kvm_init

 arch/arm/include/asm/kvm_host.h   |    3 ++
 arch/arm/include/uapi/asm/kvm.h   |   16 +++++++
 arch/arm/kvm/arm.c                |    2 +
 arch/arm/kvm/guest.c              |   92 ++++++++++++++++++++++++++++++++++++-
 arch/arm64/include/uapi/asm/kvm.h |   25 ++++++++++
 virt/kvm/arm/arch_timer.c         |   34 ++++++++++++++
 virt/kvm/arm/vgic.c               |    1 -
 7 files changed, 171 insertions(+), 2 deletions(-)

-- 
1.7.10.4
