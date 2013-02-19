From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:47:34 +0900
Subject: [PATCH v2 0/8] ARM: shmobile: kzm9g reference SMP and cleanup
Message-ID: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series:

* Tweaks the defconfig to allow SMP kzm9g reference to successfully boot.
* Removes the use of early devices from reference kzm9g reference DT
* Makes various other minor cleanups to kzm9g reference DT

Clarification of SMP fix:
* Diabling CONFIG_PREEMPT is sufficent to allow the existing
  kzm9g reference DT code to boot SMP.

Merge:

My plan to merge this is:
* Add the defconfig change to a defconfig branch.
* Add the sh73a0 patches to an soc branch.
* Then rebase the existing boards-kzm9g-reference breanch on top of
  the soc branch.
* Then apply the kzm9g patches in this series to boards-kzm9g-reference,
  squashing the "ARM: shmobile: kzm9g: Do not use early devices" change to
  avoid breaking bisection.

Difference to v1:
* Added "shmobile: sh73a0: Do not use early devices with DT reference"
* Added "shmobile: sh73a0: Remove warning about SMP"
* Added "shmobile: kzm9g: Do not use early devices"

Simon Horman (8):
  ARM: shmobile: kzm9g: defconfig: do not enable PREEMPT
  ARM: shmobile: sh73a0: Remove sh73a0_init_irq_dt()
  ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
  ARM: shmobile: sh73a0: Remove warning about SMP
  ARM: shmobile: sh73a0: Do not use early devices with DT reference
  ARM: shmobile: kzm9g: Do not use early devices
  ARM: shmobile: kzm9g: Remove warning about SMP
  ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START

 arch/arm/configs/kzm9g_defconfig               |    1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   21 ++------------
 arch/arm/mach-shmobile/include/mach/common.h   |    2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c           |    8 ------
 arch/arm/mach-shmobile/setup-sh73a0.c          |   36 ++++++++----------------
 5 files changed, 16 insertions(+), 52 deletions(-)

-- 
1.7.10.4
