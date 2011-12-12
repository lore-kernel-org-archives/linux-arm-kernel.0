From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Dec 2011 18:31:38 +0000
Subject: [GIT PULL] kexec and soft-reboot for 3.3
Message-ID: <20111212183138.GG15554@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these kexec and soft-reboot patches for 3.3. Despite my previous
claims (see v8 of the series), there are only 4 patches here.

Taken against devel-stable from today. I can rebase if required.

Thanks,

Will


The following changes since commit ad622671a4da0b6db1c1382e6345e1361c5fbab8:

  ARM: 7183/1: vic: register the VIC for ST-modified VIC's (2011-12-11 09:56:57 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kexec/soft-reboot

Will Deacon (4):
      ARM: lib: add call_with_stack function for safely changing stack
      ARM: reset: implement soft_restart for jumping to a physical address
      ARM: stop: execute platform callback from cpu_stop code
      ARM: kexec: use soft_restart for branching to the reboot buffer

 arch/arm/Kconfig                |    2 +-
 arch/arm/kernel/machine_kexec.c |   15 ++---------
 arch/arm/kernel/process.c       |   50 +++++++++++++++++++++++++++++++-------
 arch/arm/kernel/smp.c           |    4 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/call_with_stack.S  |   44 ++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/lib/call_with_stack.S
