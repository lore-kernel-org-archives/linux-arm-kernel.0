From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 12 Feb 2015 06:34:56 +0000
Subject: [PATCH 0/2] arm/arm64: Detect Xen support earlier
Message-ID: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series move the detection of running on Xen earlier. This is
required in order to support earlyprintk via Xen and selecting the preferred
console.

Ard, the patch to move the call earlier (see #2) differed from the one I sent
you privately mostly because it's not possible to translate an IRQ before the
GIC has been initialized.

Let me know if it works for you.

Sincerely yours,

Julien Grall (1):
  arm/xen: Correctly check if the event channel interrupt is present

Stefano Stabellini (1):
  arm,arm64/xen: move Xen initialization earlier

 arch/arm/include/asm/xen/hypervisor.h |  8 +++++
 arch/arm/kernel/setup.c               |  2 ++
 arch/arm/xen/enlighten.c              | 58 +++++++++++++++++++++--------------
 arch/arm64/kernel/setup.c             |  2 ++
 4 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.1.0
