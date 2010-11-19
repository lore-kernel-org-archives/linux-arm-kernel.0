From: rabin@rab.in (Rabin Vincent)
Date: Fri, 19 Nov 2010 22:12:47 +0530
Subject: [GIT PULL] ARM ftrace function graph tracing support
Message-ID: <20101119164154.GA23185@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

These are the function graph tracing patches posted to the list a couple
of weeks ago (and the versatile sched_clock() notrace patch).  I'm
trying to get this to you via a pull request instead of putting them in
the patch system because I'd like to preserve Tim's Author: line on one
of the patches.

Please pull or let me know if you'd like this done differently, thanks.

Rabin

The following changes since commit 0143832cc96d0bf78486297aad5c8fb2c2ead02a:

  Merge branch 'urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6 (2010-11-13 10:00:15 -0800)

are available in the git repository at:

  git://github.com/rabinv/linux-2.6.git ftrace

Rabin Vincent (5):
      ARM: versatile: ensure sched_clock() is notrace
      ARM: place C irq handlers in IRQ_ENTRY for ftrace
      ARM: ftrace: use gas macros to avoid code duplication
      ARM: ftrace: graph tracer + dynamic ftrace
      ARM: ftrace: enable function graph tracer

Tim Bird (1):
      ARM: ftrace: function graph tracer support

 arch/arm/Kconfig                      |    1 +
 arch/arm/Kconfig.debug                |    2 +-
 arch/arm/include/asm/system.h         |    5 +
 arch/arm/include/asm/traps.h          |   23 ++++-
 arch/arm/kernel/Makefile              |    3 +-
 arch/arm/kernel/entry-common.S        |  202 ++++++++++++++++++++++-----------
 arch/arm/kernel/ftrace.c              |  103 ++++++++++++++++-
 arch/arm/kernel/irq.c                 |    4 +-
 arch/arm/kernel/smp.c                 |    5 +-
 arch/arm/kernel/vmlinux.lds.S         |    1 +
 arch/arm/plat-versatile/sched-clock.c |    1 +
 11 files changed, 273 insertions(+), 77 deletions(-)
