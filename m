From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Apr 2016 11:52:11 +0200
Subject: [PULL 0/4] KVM/ARM Fixes for v4.6-rc4
Message-ID: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Radim,

Here's another set of fixes for KVM/ARM for this release.  I guess this was
expected given the size of our patch queue for this merge window.

The following changes since commit 5f5560b1c5f3a80e91c6babb2da34a51943bbdec:

  arm64: KVM: Register CPU notifiers when the kernel runs at HYP (2016-03-31 10:27:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.6-rc4

for you to fetch changes up to 06a71a24bae57a07afee9cda6b00495347d8a448:

  arm64: KVM: unregister notifiers in hyp mode teardown path (2016-04-06 13:47:52 +0200)


Thanks,
-Christoffer

----------------------------------------------------------------
KVM/ARM Fixes for v4.6-rc4

Addresses:
 - Wrong indentation in the PMU code from the merge window
 - A long-time bug occuring with running ntpd on the host, candidate for stable
 - Properly handle (and warn about) the unsupported configuration of running on
   systems with less than 40 bits of PA space
 - More fixes to the PM and hotplug notifier stuff from the merge window

----------------------------------------------------------------
Marc Zyngier (2):
      KVM: arm/arm64: Handle forward time correction gracefully
      arm64: KVM: Warn when PARange is less than 40 bits

Sudeep Holla (1):
      arm64: KVM: unregister notifiers in hyp mode teardown path

Will Deacon (1):
      arm64: KVM: Add braces to multi-line if statement in virtual PMU code

 arch/arm/kvm/arm.c                | 13 ++++++++---
 arch/arm64/include/asm/kvm_arm.h  |  6 ++---
 arch/arm64/include/asm/kvm_asm.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h |  7 +++---
 arch/arm64/kvm/hyp/s2-setup.c     | 39 +++++++++++++++++++++++++++++--
 virt/kvm/arm/arch_timer.c         | 49 +++++++++++++++++++++++++++++++--------
 virt/kvm/arm/pmu.c                |  3 ++-
 7 files changed, 95 insertions(+), 24 deletions(-)
