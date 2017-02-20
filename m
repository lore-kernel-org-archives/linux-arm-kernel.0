From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Feb 2017 12:30:10 +0000
Subject: [PATCH 0/2] arm{,64}/kvm: survive unknown traps from guests
Message-ID: <1487593812-9174-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As future versions of the architecture add trappable functionality, it is
possible that KVM guests may be able to trigger exceptions that KVM doesn't
currently understand. Currently, we will BUG() if we take such an exception.

While we can't handle such traps very gracefully, we should limit any fallout
to the guest, rather than allowing guests to potentially bring down the host.

These patches try to make arm/arm64 KVM robust in these cases.

Thanks,
Mark.

Mark Rutland (2):
  arm/kvm: survive unknown traps from guests
  arm64/kvm: survive unknown traps from guests

 arch/arm/include/asm/kvm_arm.h |  1 +
 arch/arm/kvm/handle_exit.c     | 19 ++++++++++++-------
 arch/arm64/kvm/handle_exit.c   | 19 ++++++++++++-------
 3 files changed, 25 insertions(+), 14 deletions(-)

-- 
1.9.1
