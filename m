From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Jun 2015 15:41:31 +0100
Subject: [PATCH v2 0/3] PSCI: system suspend support
In-Reply-To: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
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

Changes v1[3]->v2:
	- Introduces generic macro for PSCI_FN_NATIVE
	- Removed redundant code and renamed new PSCI_FN macros with
	  v1.0 tag as suggested by Lorenzo

Regards,
Sudeep

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git psci/unification
[2] http://www.spinics.net/lists/devicetree/msg82017.html
[3] http://www.spinics.net/lists/arm-kernel/msg425793.html


Sudeep Holla (3):
  arm64: kernel: rename __cpu_suspend to keep it aligned with arm
  drivers: firmware: psci: define more generic PSCI_FN_NATIVE macro
  drivers: firmware: psci: add system suspend support

 arch/arm64/include/asm/cpuidle.h |  8 ++-----
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/kernel/cpuidle.c      |  4 ++--
 arch/arm64/kernel/psci.c         |  2 +-
 arch/arm64/kernel/suspend.c      |  6 ++---
 drivers/firmware/psci.c          | 48 +++++++++++++++++++++++++++++++++-------
 include/uapi/linux/psci.h        |  3 +++
 7 files changed, 52 insertions(+), 21 deletions(-)

-- 
1.9.1
