From: tixy@yxit.co.uk (Tixy)
Date: Mon,  4 Apr 2011 21:33:14 +0100
Subject: [PATCH 0/4] ARM: kprobes: Fixes for ARM instruction emulation
Message-ID: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kprobes are inserted into code an ARM instruction is replaced
by a breakpoint. When this is hit, the original instruction must be
emulated out-of-line. This patchset fixes some bugs in this emulation.

[PATCH 1/4] ARM: kprobes: Fix probing of conditionally executed instructions
[PATCH 2/4] ARM: kprobes: Remove redundant condition checks from simulation routines
[PATCH 3/4] ARM: kprobes: Fix emulation of CMP, CMN, TST and TEQ instructions.
[PATCH 4/4] ARM: kprobes: Fix emulation of data processing (immediate) instructions
