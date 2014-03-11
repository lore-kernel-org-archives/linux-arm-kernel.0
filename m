From: dave.long@linaro.org (David Long)
Date: Tue, 11 Mar 2014 14:36:09 -0400
Subject: [GIT PULL] uprobes: Add uprobes support for ARM
In-Reply-To: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
Message-ID: <531F5799.2070302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 2d100bc71fcada9e8252fbee3e414add292d118c:

  Merge tag 'v3.14-rc5' of https://github.com/torvalds/linux (2014-03-02 23:04:25 -0500)

are available in the git repository at:


  git://git.linaro.org/people/dave.long/linux.git uprobes-v7

for you to fetch changes up to e55c35236b8adf79453a998506ec6081833b9484:

  ARM: add uprobes support (2014-03-11 11:40:29 -0400)

----------------------------------------------------------------
David A. Long (15):
      uprobes: Kconfig dependency fix
      ARM: Fix missing includes in kprobes sources
      uprobes: allow ignoring of probe hits
      ARM: move shared uprobe/kprobe definitions into new include file
      ARM: Move generic arm instruction parsing code to new files for sharing between features
      ARM: move generic thumb instruction parsing code to new files for use by other feature
      ARM: use a function table for determining instruction interpreter action
      ARM: Remove use of struct kprobe from generic probes code
      ARM: Make the kprobes condition_check symbol names more generic
      ARM: Change more ARM kprobes symbol names to something more generic
      ARM: Rename the shared kprobes/uprobe return value enum
      ARM: Change the remaining shared kprobes/uprobes symbols to something generic
      ARM: Add an emulate flag to the kprobes/uprobes instruction decode functions
      ARM: Make arch_specific_insn a define for new arch_probes_insn structure
      ARM: add uprobes support

 arch/Kconfig                       |    6 +-
 arch/arm/Kconfig                   |    3 +
 arch/arm/include/asm/kprobes.h     |   17 +-
 arch/arm/include/asm/probes.h      |   43 ++
 arch/arm/include/asm/ptrace.h      |    6 +
 arch/arm/include/asm/thread_info.h |    5 +-
 arch/arm/include/asm/uprobes.h     |   45 ++
 arch/arm/kernel/Makefile           |    7 +-
 arch/arm/kernel/kprobes-arm.c      |  806 +++----------------------
 arch/arm/kernel/kprobes-common.c   |  469 +--------------
 arch/arm/kernel/kprobes-test-arm.c |    1 +
 arch/arm/kernel/kprobes-test.c     |   12 +-
 arch/arm/kernel/kprobes-thumb.c    | 1145 ++++++------------------------------
 arch/arm/kernel/kprobes.c          |   25 +-
 arch/arm/kernel/kprobes.h          |  400 +------------
 arch/arm/kernel/probes-arm.c       |  734 +++++++++++++++++++++++
 arch/arm/kernel/probes-arm.h       |   73 +++
 arch/arm/kernel/probes-thumb.c     |  882 +++++++++++++++++++++++++++
 arch/arm/kernel/probes-thumb.h     |   97 +++
 arch/arm/kernel/probes.c           |  455 ++++++++++++++
 arch/arm/kernel/probes.h           |  407 +++++++++++++
 arch/arm/kernel/signal.c           |    4 +
 arch/arm/kernel/uprobes-arm.c      |  234 ++++++++
 arch/arm/kernel/uprobes.c          |  210 +++++++
