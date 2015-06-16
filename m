From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Jun 2015 14:50:38 +0100
Subject: [PATCH 0/2] PSCI: system suspend support
Message-ID: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These couple of patches add generic support for PSCI system suspend.

The first patch aligns the cpu_{suspend,resume} functions so that they
have identical prototype both on ARM32 and ARM64. The second patch adds
the system suspend support on top of PSCIv1.0 implementation.

The series is built on top of M.Rutland's branch[1] + Lorenzo's PSCI
v1.0 support[2]. The wakeup source is not scope of these patches. It
needs to addressed separately.

Platforms with PSCI v1.0 supported in the firmware and SYSTEM_SUSPEND
feature advertised as available is required for testing this. This was
tested in ARM on Juno platform.

Regards,
Sudeep

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git psci/unification
[2] http://www.spinics.net/lists/devicetree/msg82017.html

Sudeep Holla (2):
  arm64: kernel: rename __cpu_suspend to keep it aligned with arm
  drivers: firmware: psci: add system suspend support

 arch/arm64/include/asm/cpuidle.h |  8 ++------
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/kernel/cpuidle.c      |  4 ++--
 arch/arm64/kernel/psci.c         |  2 +-
 arch/arm64/kernel/suspend.c      |  6 +++---
 drivers/firmware/psci.c          | 39 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/psci.h        |  2 ++
 7 files changed, 50 insertions(+), 13 deletions(-)

-- 
1.9.1
