From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  6 Jul 2015 14:49:54 +0200
Subject: [PATCH 0/2] KVM: arm/arm64: Guest synchronous halt/resume
Message-ID: <1436186996-22528-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces the capability to synchronously exit the guest
and prevent it from being re-entered.

This functionality is requested for IRQ forwarding where we need to make
sure the guest has exited and is prevented from being rescheduled until
we complete the forwarding state change.

This series does not introduce any user of the functionality. First user
will be IRQ forwarding. The split is done to ease the review process.

can be found at:
https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.2-rc1-bypass-fwd-v2

Best Regards

Eric

History:

PATCH:
- just added __maybe_unused following Marc's advice

RFC life before:
- originally part of [RFC 00/17] ARM IRQ forward control based on IRQ
  bypass manager (https://lkml.org/lkml/2015/7/2/268) and isolated in
  this series.

Eric Auger (2):
  KVM: arm: rename pause into power_off
  kvm: arm/arm64: implement kvm_arm_[halt,resume]_guest

 arch/arm/include/asm/kvm_host.h   |  5 ++++-
 arch/arm/kvm/arm.c                | 41 +++++++++++++++++++++++++++++++++------
 arch/arm/kvm/psci.c               | 10 +++++-----
 arch/arm64/include/asm/kvm_host.h |  3 +++
 4 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.9.1
