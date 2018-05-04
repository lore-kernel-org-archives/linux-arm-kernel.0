From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Fri,  4 May 2018 13:14:31 +0900
Subject: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on unsafe
 functions
Message-ID: <152540727123.29650.13679359124038587629.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the 3rd version of bugfix series for kprobes on arm.
This series fixes 4 different issues which I found.

 - Fix to use smp_processor_id() after disabling preemption.
 - Prohibit probing on optimized_callback() for avoiding
   recursive probe.
 - Prohibit kprobes on do_undefinstr() by same reason.
 - Prohibit kprobes on get_user() by same reason.

>From v2, I included another 2 bugfixes (1/4 and 2/4)
which are not merged yet, and added "Cc: stable at vger.kernel.org",
since there are obvious bugs.

Thanks,

---

Masami Hiramatsu (4):
      arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
      arm: kprobes: Prohibit probing on optimized_callback
      arm: kprobes: Prohibit kprobes on do_undefinstr
      arm: kprobes: Prohibit kprobes on get_user functions


 arch/arm/include/asm/assembler.h  |   10 ++++++++++
 arch/arm/kernel/traps.c           |    5 ++++-
 arch/arm/lib/getuser.S            |   10 ++++++++++
 arch/arm/probes/kprobes/opt-arm.c |    4 +++-
 4 files changed, 27 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
