From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 09:17:47 +0100
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <200910010904.18923.dk-arm-linux@gmx.de>
References: <200910010904.18923.dk-arm-linux@gmx.de>
Message-ID: <20091001081747.GA21935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 09:04:18AM +0200, Dieter Kiermaier wrote:
> Once I got a backtrace like:
> ------------[ cut here ]------------
> WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
> Modules linked in:
> [<c002a748>] (unwind_backtrace+0x0/0xd8) from [<c003931c>] (warn_slowpath_common+0x4c/0x68)
> [<c003931c>] (warn_slowpath_common+0x4c/0x68) from [<c0026844>] (cpu_idle+0x74/0xbc)
> [<c0026844>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] (start_kernel+0x22c/0x27c)
> [<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
> ---[ end trace fb05d74310f1e273 ]---

This is indicative of something causing interrupts to be disabled in
the cpu idle loop after the pm specific idle loop returns.  That could
be a buggy pm_idle implementation, or, as you seem to have identified,
not using your debugger appears to solve the problem.
