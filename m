From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Wed, 29 May 2013 13:25:14 +0800
Subject: ftrace calltrace when boot through kexec
Message-ID: <51A5913A.5030302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When I reboot a preempt_rt 3.4 kernel with cortex a15 tc2 board thru 
kexec, I got below calltrace appeared:

------------[ cut here ]------------
WARNING: at kernel/trace/ftrace.c:1584 ftrace_bug+0x1e0/0x224()
Modules linked in:
[<c0017e14>] (unwind_backtrace+0x0/0x104) from [<c062a468>] 
(dump_stack+0x20/0x24)
[<c062a468>] (dump_stack+0x20/0x24) from [<c00265a4>] 
(warn_slowpath_common+0x64/0x74)
[<c00265a4>] (warn_slowpath_common+0x64/0x74) from [<c00265e0>] 
(warn_slowpath_null+0x2c/0x34)
[<c00265e0>] (warn_slowpath_null+0x2c/0x34) from [<c00bf70c>] 
(ftrace_bug+0x1e0/0x224)
[<c00bf70c>] (ftrace_bug+0x1e0/0x224) from [<c00c03b4>] 
(ftrace_process_locs+0x880/0x930)
[<c00c03b4>] (ftrace_process_locs+0x880/0x930) from [<c082d018>] 
(ftrace_init+0xb4/0x194)
[<c082d018>] (ftrace_init+0xb4/0x194) from [<c081e8c4>] 
(start_kernel+0x338/0x348)
[<c081e8c4>] (start_kernel+0x338/0x348) from [<80008054>] (0x80008054)
---[ end trace af5b256dd27bb7ab ]---
ftrace failed to modify [<c0022b88>] platform_cpu_kill+0x10/0x1c
  actual: 00:40:bd:e8

Add notrace before platform_cpu_kill can workaround this calltrace, but 
it is weird that this problem can't
reproduce in another cortex-a9 (xilinx-zynq) board, could someone give 
some hints about this? Thanks.

Regards,
Xiao
