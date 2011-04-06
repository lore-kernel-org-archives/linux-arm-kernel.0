From: tixy@yxit.co.uk (Tixy)
Date: Wed,  6 Apr 2011 11:17:08 +0100
Subject: [PATCH v2 0/4] ARM: kprobes: Fixes for ARM instruction emulation
	(part 1)
Message-ID: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kprobes are inserted into code an ARM instruction is replaced
by a breakpoint. When this is hit, the original instruction must be
emulated out-of-line. This patchset fixes some bugs in this emulation.

v2  Move definitions of __check_xx functions from the .h to .c file.

[PATCH v2 1/4] ARM: kprobes: Fix probing of conditionally executed instructions
[PATCH v2 2/4] ARM: kprobes: Remove redundant condition checks from simulation routines
[PATCH v2 3/4] ARM: kprobes: Fix emulation of CMP, CMN, TST and TEQ instructions.
[PATCH v2 4/4] ARM: kprobes: Fix emulation of Data-processing (immediate) instructions
