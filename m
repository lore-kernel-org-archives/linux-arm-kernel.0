From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2012 10:53:02 +0000
Subject: Versatile randconfig build failure
Message-ID: <20121122105302.GE5764@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last nights Versatile randconfig failed to build for various reasons,
but also this non-driver related issue (as ever, these are linker
messages, so the files pointed at are only approximations):

kernel/built-in.o: In function `perf_prepare_sample':
jump_label.c:(.text+0x3e0ac): undefined reference to `perf_misc_flags'
jump_label.c:(.text+0x3e0d4): undefined reference to `perf_instruction_pointer'

We have:
- CONFIG_PERF_EVENTS=y
- CONFIG_HW_PERF_EVENTS=n

which allows the code in kernel/events/ to be built (which references the
two above functions) but with HW_PERF_EVENTS unset, we don't provide them.

Config:

http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2805

Log:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2805
