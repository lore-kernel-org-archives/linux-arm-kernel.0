From: liuj97@gmail.com (Jiang Liu)
Date: Fri, 27 Sep 2013 16:04:40 +0800
Subject: [RFT PATCH v1 0/7] enable FPSIMD lazy save and restore for arm64
Message-ID: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

This patchset enables FPSIMD lazy save and restore for ARM64, you could
apply it against v3.12-rc2.

We have done basic functional tests on ARM fast model, but still lack
of detail performance benchmark on real hardware platforms. We would
appreciate if you could help to test it on really hardware platforms!

The first two patches are bugfixes for current FPSIMD implementations.
The other five patches implements FPSIMD lazy save and restore.

Jiang Liu (7):
  arm64: fix possible invalid FPSIMD initialization state
  arm64: restore FPSIMD to default state for kernel and signal contexts
  arm64: implement basic lazy save and restore for FPSIMD registers
  arm64: provide boot option "eagerfpu" to control FPSIMD restore policy
  arm64: reuse FPSIMD hardware context if possible
  amd64: avoid saving and restoring FPSIMD registers until threads
    access them
  arm64: disable lazy load if FPSIMD registers are frequently used

 Documentation/kernel-parameters.txt |   5 +-
 arch/arm64/include/asm/fpsimd.h     |  12 +-
 arch/arm64/kernel/fpsimd.c          | 217 ++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/process.c         |   4 +-
 arch/arm64/kernel/signal.c          |  12 +-
 arch/arm64/kernel/signal32.c        |  12 +-
 arch/arm64/kernel/smp.c             |   1 +
 7 files changed, 238 insertions(+), 25 deletions(-)

-- 
1.8.1.2
