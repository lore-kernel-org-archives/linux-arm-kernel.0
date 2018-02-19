From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Feb 2018 15:39:35 +0000
Subject: [PATCH v2 0/2] arm64: Unimplemented syscall kernel message
In-Reply-To: <20180201221338.9952-1-michael.weiser@gmx.de>
References: <20180122131851.GA28638@arm.com>
 <20180201221338.9952-1-michael.weiser@gmx.de>
Message-ID: <20180219153934.GA1740@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Thu, Feb 01, 2018 at 11:13:35PM +0100, Michael Weiser wrote:
> I've dropped the message from the compat change, which makes it much
> more straight-forward. We are still dropping the offending log message
> from do_ni_syscall(). The second change now just mirrors the part of arm
> behaviour in compat_arm_syscall() that raises SIGILL for (most)
> unimplemented syscalls. Finally show_unhandled_signals is disabled by
> default.
> 
> All are compile-tested as well as manually prodded with some randomly
> chosen syscall numbers from aarch64 and arm-eabi binaries while running
> under qemu-system-aarch64. New show_unhandled_signals defaults and
> enabling via /proc/sys have been tested with a minimal segfaulting test
> program.

Thanks, I'll pick these up for 4.17.

Will
