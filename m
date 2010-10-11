From: naveen.maillist@gmail.com (Naveen Atmakuri)
Date: Mon, 11 Oct 2010 11:31:36 +0530
Subject: Linux kernel 2.6.28.10 failes when tried to mount JFFS filesystem
Message-ID: <AANLkTinYBNT0FtpYhq4J6BhJLs5TO3ZSRi1RSh71JzZZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi All,

I am trying to boot Linux kernel 2.6.28.10 kernel on a board which is based
on ARM Cortex-A9. The tool chain that I am using is "Sourcery G++ Lite
2008q3-72". When I tried to mount the JFFS2 filesystem, kernel crash occurs.
Here is the dump of the crash.

#########################################################################################################
*VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 96K
ARM Profiler Enabled
Unable to handle kernel paging request at virtual address 56bbe50f
pgd = c0004000
[56bbe50f] *pgd=00000000
Internal error: Oops: 805 [#1] SMP
Modules linked in:
CPU: 0    Not tainted  (2.6.28.10-arm2-0.1.5 #8)
PC is at free_block+0x68/0x13c
LR is at drain_array+0xa0/0xe0
pc : [<c0084440>]    lr : [<c00845b4>]    psr: 00000093
sp : c7869f48  ip : c7861000  fp : 00000000
r10: 0000000b  r9 : c7805e74  r8 : 00000000
r7 : c7800cc0  r6 : 00000000  r5 : c7861cc0  r4 : c7802aa0
r3 : 21b81a61  r2 : 56bbe50f  r1 : c0426c20  r0 : 00000016
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 0000404a  DAC: 00000017
Process events/0 (pid: 15, stack limit = 0xc7868268)
Stack: (0xc7869f48 to 0xc786a000)
9f40:                   c7805e74 0000000b c7805e60 c7802aa0 c7800cc0
00000000
9f60: 00000000 c00845b4 c7802aa0 c7800cc0 00000000 c7868000 c0442d78
c008476c
9f80: 00000000 c0442d78 c781a820 c0442d78 c7868000 c0084724 c781a824
c0046df4
9fa0: c781a82c c7869fc8 c781a824 c781a820 00000000 c0046f30 00000000
00000000
9fc0: c785b680 c004a8e0 c7869fc8 c7869fc8 00000000 c781a820 c0046e88
00000000
9fe0: 00000000 c004a610 00000000 00000000 00000000 c0021bf8 00000000
00000000
[<c0084440>] (free_block+0x68/0x13c) from [<c00845b4>]
(drain_array+0xa0/0xe0)
[<c00845b4>] (drain_array+0xa0/0xe0) from [<c008476c>]
(cache_reap+0x48/0x124)
[<c008476c>] (cache_reap+0x48/0x124) from [<c0046df4>]
(run_workqueue+0xa8/0x13c
)
[<c0046df4>] (run_workqueue+0xa8/0x13c) from [<c0046f30>]
(worker_thread+0xa8/0x
bc)
[<c0046f30>] (worker_thread+0xa8/0xbc) from [<c004a610>] (kthread+0x4c/0x78)
[<c004a610>] (kthread+0x4c/0x78) from [<c0021bf8>]
(kernel_thread_exit+0x0/0x8)
Code: e591c01c e7974100 e59c2004 e59c3000 (e5823000)
---[ end trace fd4f70abfa740a4c ]---
JFFS2 warning: (240) jffs2_do_read_inode_internal: Truncating ino #1539 to
15188
 bytes failed because it only had 3516 bytes to start with!*
#############################################################################################################

It seems like the funtion "kernel_thread_exit" is causing the crash. But I
couldnot understand why this is happening. With the same kernel when I tried
to mount the NFS filesystem it works fine. Could anybody help me resolving
this issue?

Thanks in Advance,
-Naveen.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101011/7efe36e9/attachment-0001.html>
