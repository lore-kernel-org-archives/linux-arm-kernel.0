From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Sat, 15 Sep 2012 12:46:02 +0200
Subject: Bad traps for unaligned access in STM instruction
Message-ID: <20120915104602.GY1943@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm trying to diagnose a problem... on armv5tel, I have a userland software that runs an
STM instruction in those conditions:
r2             0xbeffeb95
r3             0x400000
r4             0x0

Instruction: stm     r2, {r3, r4}

After stepping the instruction, I get:
(gdb) x/xg $r2
0xbeffeb95:     0xd800000000004000

While it should be: 0x0000000000400000

What can be going wrong?        Linux 3.4.6 on armv5tel, gnueabi.
I know the kernel trap goes in, I told the kernel to report the unaligned
accesses, but I think it should fix them. From dmesg:

Alignment trap: mkfs.btrfs (28871) PC=0x00039ac0 Instr=0xe8820018
Address=0xbeffeb95 FSR 0x801

I'll start looking at the arm traps for unaligned accesses, but maybe someone
here can give a quick answer.

Regards,
Llu?s.
