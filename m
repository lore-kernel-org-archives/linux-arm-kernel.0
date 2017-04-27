From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 18:44:35 +0100
Subject: [PATCHv2 0/2] arm64: fix hotplug rwsem boot fallout
Message-ID: <1493315077-19496-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches address a boot failure on arm64 observed when booting a kernel
built with the hotplug rwsem changes currently queued in the tip smp/hotplug
branch.

I've given these a spin on Juno R1, which now boots happily.

FWIW, I also did a test-merge with the arm64 for-next/core branch, which git
was able to figure it out automatically. The result builds cleanly and boots
without issue on Juno R1.

Catalin/Will, assuming there are no further gotchas, are you happy for the
arm64 patch to go via the tip tree?

Thanks,
Mark.

Since v1 [1]:
* Fix update_cpu_capabilities() by splitting boot/secondary

[1] https://lkml.kernel.org/r/20170427154806.GA6646 at leverpostej

Mark Rutland (1):
  arm64: cpufeature: use static_branch_enable_cpuslocked()

Sebastian Andrzej Siewior (1):
  jump_label: Provide static_key_[enable|/slow_inc]_cpuslocked()

 arch/arm64/include/asm/cpufeature.h |  5 +++--
 arch/arm64/kernel/cpu_errata.c      | 13 ++++++++++++-
 arch/arm64/kernel/cpufeature.c      |  5 ++++-
 arch/arm64/kernel/smp.c             |  7 +++----
 include/linux/jump_label.h          |  7 +++++++
 kernel/jump_label.c                 | 10 ++++++++++
 6 files changed, 39 insertions(+), 8 deletions(-)

-- 
1.9.1
