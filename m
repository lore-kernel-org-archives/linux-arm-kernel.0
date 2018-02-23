From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Feb 2018 19:00:22 +0100
Subject: [PULL 0/2] KVM/ARM Fixes for v4.16
Message-ID: <20180223180024.8846-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Radim,

Here's the first round of KVM/ARM fixes for v4.16.

Not much in here; we fix the interaction of userspace irqchip VMs with in-kernel
irqchip VMs and make sure we can build 32-bit KVM/ARM with gcc-8.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-for-v4.16-1

for you to fetch changes up to 67870eb1204223598ea6d8a4467b482e9f5875b5:

  ARM: kvm: fix building with gcc-8 (2018-02-15 20:58:36 +0100)

Thanks,
-Christoffer

Arnd Bergmann (1):
  ARM: kvm: fix building with gcc-8

Christoffer Dall (1):
  KVM: arm/arm64: Fix arch timers with userspace irqchips

 arch/arm/kvm/hyp/Makefile    |   5 ++
 arch/arm/kvm/hyp/banked-sr.c |   4 ++
 virt/kvm/arm/arch_timer.c    | 116 ++++++++++++++++++++++++-------------------
 3 files changed, 73 insertions(+), 52 deletions(-)

-- 
2.14.2
