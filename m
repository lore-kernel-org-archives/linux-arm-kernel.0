From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 14:20:01 +0100
Subject: [PATCH 0/5] A handful of KVM/ARM fixes
Message-ID: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small patch series that I accumulated while tracking what
turned out to be an unrelated issue.

The first patch has already been posted a while ago and included here
for completeness. The others are fairly simple missing barriers/clear
exclusives that are actually required.

This has been tested on TC2, and is also available in my tree:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/fixes-3.10-rc6

Marc Zyngier (5):
  ARM: KVM: perform save/restore of PAR
  ARM: KVM: add missing dsb before invalidating Stage-2 TLBs
  ARM: KVM: make sure maintainance operation complete before world
    switch
  ARM: KVM: clear exclusive monitor on all exception returns
  ARM: KVM: issue a DSB after cache maintainance operations

 arch/arm/include/asm/kvm_asm.h | 22 ++++++++++++----------
 arch/arm/kvm/coproc.c          |  6 ++++++
 arch/arm/kvm/interrupts.S      | 25 ++++++++++++++++++++++++-
 arch/arm/kvm/interrupts_head.S | 10 ++++++++--
 4 files changed, 50 insertions(+), 13 deletions(-)

-- 
1.8.2.3
