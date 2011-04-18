From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:53 +0100
Subject: [PATCH 0/5] ARM: kprobes: Fixes for ARM instruction emulation (part 5)
Message-ID: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(This is a fifth set of patches)

When kprobes are inserted into code an ARM instruction is replaced
by a breakpoint. When this is hit, the original instruction must be
emulated out-of-line. This patchset fixes still more bugs in the
instruction decoding and emulation.

[PATCH 1/5] ARM: kprobes: Reject probing of all coprocessor instructions
[PATCH 2/5] ARM: kprobes: Consolidate stub decoding functions
[PATCH 3/5] ARM: kprobes: Reject probing of SETEND instructions
[PATCH 4/5] ARM: kprobes: Fix emulation of PLD instructions
[PATCH 5/5] ARM: kprobes: Remove redundant code in space_1111
