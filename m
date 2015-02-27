From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Feb 2015 09:11:36 +0000
Subject: [PATCH resend 0/2] get rid of ARM/KVM bounce page
Message-ID: <1425028298-17289-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated the patch sent by Arnd last month, and rebased my bounce page
removal patch on top of it.

The extended VA range patches will functionally depend on these, but until
the core one lands in the arm64 tree, systems that need it to boot with
VA_BITS <= PA_BITS (such as AMD Seattle) will not boot anyway. There should
not be any merge conflicts, so these patches can go through the arm KVM tree
as far as I am aware.

Ard Biesheuvel (1):
  ARM, arm64: kvm: get rid of the bounce page

Arnd Bergmann (1):
  ARM: KVM: avoid "HYP init code too big" error

 arch/arm/kernel/vmlinux.lds.S   | 35 +++++++++++++++++++++++++++++-----
 arch/arm/kvm/init.S             |  3 +++
 arch/arm/kvm/mmu.c              | 42 +++++------------------------------------
 arch/arm64/kernel/vmlinux.lds.S | 18 ++++++++++++------
 4 files changed, 50 insertions(+), 48 deletions(-)

-- 
1.8.3.2
