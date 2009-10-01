From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 1 Oct 2009 09:04:18 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
Message-ID: <200910010904.18923.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

hm - it seems to be suspect but I've got random kernel crashes with latest openrd git kernel from:

http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git
(BTW: are there any news on bringing the openrd kernel to mainline?)

It looks like there is something wrong in cpu_idle()???
kernel: Linux version 2.6.31-rc9-ge2e09ec (dieter at dk1-linux) (gcc version 4.2.0 20070413 (prerelease)) #10 PREEMPT Thu Oct 1 08:46:47 CEST 2009

Once I got a backtrace like:
------------[ cut here ]------------
WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
Modules linked in:
[<c002a748>] (unwind_backtrace+0x0/0xd8) from [<c003931c>] (warn_slowpath_common+0x4c/0x68)
[<c003931c>] (warn_slowpath_common+0x4c/0x68) from [<c0026844>] (cpu_idle+0x74/0xbc)
[<c0026844>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] (start_kernel+0x22c/0x27c)
[<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
---[ end trace fb05d74310f1e273 ]---

Many other times the system freezes and I see in the debugger:

: System
cpsr: 0xffffffff pc: 0xffffffe9
MMU: disabled, D-Cache: disabled, I-Cache: disabled
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
timeout waiting for SYSCOMP & DBGACK, last DBG_STATUS: 0
target state: halted
target halted in Thumb state due to debug-request, current mode: Abort
cpsr: 0x00000037 pc: 0xc046a74a
MMU: disabled, D-Cache: disabled, I-Cache: disabled

I've written yesterday in a email to openrd google group "openrd kernel questions" that I've got problems with enabled EHCI but it looks like
that wasn't the reason because today morning I got the crashes without enabled EHCI!

Have somenone else observed this earlier and how can I go on to track the bug down?

Many thanks,
Dieter
