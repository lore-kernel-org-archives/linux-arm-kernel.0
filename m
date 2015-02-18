From: julien.grall@linaro.org (Julien Grall)
Date: Wed, 18 Feb 2015 13:51:50 +0000
Subject: [PATCH v2 0/3] arm/arm64: Detect Xen support earlier
Message-ID: <1424267513-15836-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series moves the detection of running on Xen earlier. This is
required in order to support earlyprintk via Xen and selecting preferred console.

Actually, the last patch of this patch series adds HVC0 as preferred console
when running on Xen. The patch [1] was previously separetly sent by Ard.

For the maintainers, does this patch series should go in upstream via the ARM
tree or Xen tree?

Regards,

[1] https://patches.linaro.org/44633/ 

Tested-by: Ard Biesheuvel <ard@linaro.org>

Ard Biesheuvel (1):
  xen/arm: allow console=hvc0 to be omitted for guests

Julien Grall (1):
  arm/xen: Correctly check if the event channel interrupt is present

Stefano Stabellini (1):
  arm,arm64/xen: move Xen initialization earlier

 arch/arm/include/asm/xen/hypervisor.h |  8 +++++
 arch/arm/kernel/setup.c               |  2 ++
 arch/arm/xen/enlighten.c              | 62 ++++++++++++++++++++++-------------
 arch/arm64/kernel/setup.c             |  2 ++
 4 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.1.4
