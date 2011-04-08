From: tixy@yxit.co.uk (Tixy)
Date: Fri,  8 Apr 2011 15:32:52 +0100
Subject: [PATCH 0/4] ARM: kprobes: Fixes for ARM instruction emulation (part 3)
Message-ID: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(This is a third set of patches)

When kprobes are inserted into code an ARM instruction is replaced
by a breakpoint. When this is hit, the original instruction must be
emulated out-of-line. This patchset fixes yet more bugs in the
instruction decoding and emulation.

[PATCH 1/4] ARM: kprobes: Reject probing of STREX and LDREX instructions
[PATCH 2/4] ARM: kprobes: Fix emulation of LDRH, STRH, LDRSB and LDRSH instructions
[PATCH 3/4] ARM: kprobes: Reject probing of LDR/STR instructions which update PC unpredictably
[PATCH 4/4] ARM: kprobes: Fix emulation of LDRD and STRD instructions
