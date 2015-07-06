From: panand@redhat.com (Pratyush Anand)
Date: Mon,  6 Jul 2015 10:33:20 +0530
Subject: [PATCH 0/2] arm64: some symbols blacklisted for kprobing
Message-ID: <cover.1436158027.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions which are called from do_debug_execptions and all entry routines
must not allow to insert kprobe in it, otherwise we may witness a system hang.

This patch set blacklist such symbols.

Patches should be applied on top of arm64 kprobe patches [1].

[1] https://lkml.org/lkml/2015/6/15/514

Pratyush Anand (2):
  arm64: Blacklist non-kprobe-able symbols
  arm64: Make all entry code as non-kprobe-able

 arch/arm64/kernel/debug-monitors.c | 18 ++++++++++++++++++
 arch/arm64/kernel/entry.S          |  3 +++
 arch/arm64/kernel/hw_breakpoint.c  |  8 ++++++++
 arch/arm64/kernel/kgdb.c           |  4 ++++
 arch/arm64/kernel/kprobes.c        |  9 +++++++++
 arch/arm64/kernel/vmlinux.lds.S    |  1 +
 arch/arm64/mm/fault.c              |  1 +
 7 files changed, 44 insertions(+)

-- 
2.4.3
