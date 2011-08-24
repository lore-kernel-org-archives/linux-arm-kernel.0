From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 24 Aug 2011 10:21:45 -0700
Subject: [PATCH] Fix show_regs to give a backtrace
Message-ID: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, show_regs will not give a backtrace unless frame pointer is enabled.
show_regs calls __backtrace which does not support the arm unwind tables and
returns nothing if CONFIG_FRAME_POINTER is not enabled. Having a useful
backtrace when dumping registers is helpful, so fix show_regs to call into
dump_backtrace which properly handles both the CONFIG_FRAME_POINTER and the
CONFIG_ARM_UNWIND case for backtraces.
