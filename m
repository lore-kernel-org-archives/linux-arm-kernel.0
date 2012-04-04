From: joancarles@fqingenieria.es (joancarles)
Date: Wed, 04 Apr 2012 15:56:25 +0200
Subject: [3.3] vfs_read oops in
 arm/arch/plat-mxc/audmux-v2.c:audmux_read_file() in sysfs
Message-ID: <2d33222231d2b5e5b07a63ae117048c9@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

A 'cat /sys/kernel/debug/audmux/ssi7' causes following oops to be 
printed by the kernel:

Feb 17 11:12:55 192.168.1.221 kernel: [  444.320886] Unhandled fault: 
external abort on non-linefetch (0x008) at 0xf53b003c
Feb 17 11:12:55 192.168.1.221 kernel: [  444.328511] Internal error: : 
8 [#1] PREEMPT
Feb 17 11:12:55 192.168.1.221 kernel: [  444.332802] Modules linked in:
Feb 17 11:12:55 192.168.1.221 kernel: [  444.335895] CPU: 0    Not 
tainted  (3.3.0-00033-gecc726e-dirty #307)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.342309] PC is at 
audmux_read_file+0x68/0x2f4
Feb 17 11:12:55 192.168.1.221 kernel: [  444.346960] LR is at 
clk_enable+0x3c/0x48
Feb 17 11:12:55 192.168.1.221 kernel: [  444.350997] pc : [<c001b8c8>]  
  lr : [<c00190a0>]    psr: a0000013
Feb 17 11:12:55 192.168.1.221 kernel: [  444.351013] sp : c3ad3f38  ip 
: c30a4000  fp : 00000003
Feb 17 11:12:55 192.168.1.221 kernel: [  444.362519] r10: 00001000  r9 
: be83fb00  r8 : c3ad3f80
Feb 17 11:12:55 192.168.1.221 kernel: [  444.367766] r7 : c3ad3f80  r6 
: 00000007  r5 : 00031010  r4 : c30a5000
Feb 17 11:12:55 192.168.1.221 kernel: [  444.374318] r3 : f53b0000  r2 
: 0000003c  r1 : 380fa100  r0 : c068dda0
Feb 17 11:12:55 192.168.1.221 kernel: [  444.380873] Flags: NzCv  IRQs 
on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Feb 17 11:12:55 192.168.1.221 kernel: [  444.388033] Control: 0005317f  
Table: 83034000  DAC: 00000015
Feb 17 11:12:55 192.168.1.221 kernel: [  444.393802] Process cat (pid: 
1042, stack limit = 0xc3ad2270)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.399573] Stack: (0xc3ad3f38 
to 0xc3ad4000)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.403956] 3f20:              
                                         c3139180 00000000
Feb 17 11:12:55 192.168.1.221 kernel: [  444.412176] 3f40: c3bc6500 
00001000 be83fb00 c3ad3f80 00001000 c3ad2000 00000000 c0095f3c
Feb 17 11:12:55 192.168.1.221 kernel: [  444.420395] 3f60: 00000003 
c3bc6508 c3bc6500 be83fb00 00000000 00000000 00001000 c0096010
Feb 17 11:12:55 192.168.1.221 kernel: [  444.428615] 3f80: 00000000 
00000000 b6fe2050 00000000 00001000 be83fb00 00000003 00000003
Feb 17 11:12:55 192.168.1.221 kernel: [  444.436835] 3fa0: c000eb88 
c000e9e0 00001000 be83fb00 00000003 be83fb00 00001000 00000000
Feb 17 11:12:55 192.168.1.221 kernel: [  444.445052] 3fc0: 00001000 
be83fb00 00000003 00000003 00000001 00000001 00000000 00000003
Feb 17 11:12:55 192.168.1.221 kernel: [  444.453272] 3fe0: 000bec8c 
be83fae0 0000f808 b6ea8d5c 60000010 00000003 7dff7ede 749bedf1
Feb 17 11:12:55 192.168.1.221 kernel: [  444.461531] [<c001b8c8>] 
(audmux_read_file+0x68/0x2f4) from [<c0095f3c>] (vfs_read+0xb0/0x144)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.470196] [<c0095f3c>] 
(vfs_read+0xb0/0x144) from [<c0096010>] (sys_read+0x40/0x70)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.478084] [<c0096010>] 
(sys_read+0x40/0x70) from [<c000e9e0>] (ret_fast_syscall+0x0/0x2c)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.486481] Code: e1a02186 
e2822004 e3500000 e7935186 (e7937002)
Feb 17 11:12:55 192.168.1.221 kernel: [  444.503119] ---[ end trace 
4d046e31309023de ]---

Maybe someone wants to pick this up.

Regards
-- 
Joan C. Abelaira
