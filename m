From: michael.weiser@gmx.de (Michael Weiser)
Date: Thu,  1 Feb 2018 23:13:35 +0100
Subject: [PATCH v2 0/2] arm64: Unimplemented syscall kernel message
In-Reply-To: <20180122131851.GA28638@arm.com>
References: <20180122131851.GA28638@arm.com>
Message-ID: <20180201221338.9952-1-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I've dropped the message from the compat change, which makes it much
more straight-forward. We are still dropping the offending log message
from do_ni_syscall(). The second change now just mirrors the part of arm
behaviour in compat_arm_syscall() that raises SIGILL for (most)
unimplemented syscalls. Finally show_unhandled_signals is disabled by
default.

All are compile-tested as well as manually prodded with some randomly
chosen syscall numbers from aarch64 and arm-eabi binaries while running
under qemu-system-aarch64. New show_unhandled_signals defaults and
enabling via /proc/sys have been tested with a minimal segfaulting test
program.

Thanks,
Michael

Michael Weiser (3):
  arm64: Remove unimplemented syscall log message
  arm64: Mirror arm for unimplemented compat syscalls
  arm64: Disable unhandled signal log messages by default

v2:
- drop message printing from compat syscall handling

 arch/arm64/kernel/sys_compat.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/traps.c      | 10 +---------
 2 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.16.1
