From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 11 Feb 2014 21:57:18 -0800
Subject: [PATCH 0/5] aarch64 BE kvm support
Message-ID: <1392184643-6108-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Here is series that enable KVM in V8 BE image. It is addition
on top of previously posted V7 BE KVM support [1].

It was tested on aarch64 fastmodels and APM mustang board.
It was tested only with kvmtool at this point. In case of V8
BE KVM host was tested that V8 BE guest runs fine and V8 LE
guest runs too. Also V8 LE KVM regression was tested on both
V8 LE guest and V8 BE guest. Note for mixed mode Marc's
kvmtool was used and guest image had minor change that treats
all virtio in LE form.

Note first two patches are similar to V7 BE KVM patches. Last
three are new specific for V8 image.

Thanks,
Victor

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-February/009446.html

Victor Kamensky (5):
  ARM64: KVM: MMIO support BE host running LE code
  ARM64: KVM: set and get of sys registers in BE case
  ARM64: KVM: store kvm_vcpu_fault_info est_el2 as word
  ARM64: KVM: vgic_elrsr and vgic_eisr need to by byteswapped in BE case
  ARM64: KVM: fix vgic_bitmap_get_reg function for BE 64bit case

 arch/arm64/include/asm/kvm_emulate.h | 22 ++++++++++++++++++++
 arch/arm64/kvm/hyp.S                 |  9 ++++++++-
 arch/arm64/kvm/sys_regs.c            | 39 ++++++++++++++++++++++++++++++------
 virt/kvm/arm/vgic.c                  | 27 +++++++++++++++++++++++--
 4 files changed, 88 insertions(+), 9 deletions(-)

-- 
1.8.1.4

Thanks,
Victor
