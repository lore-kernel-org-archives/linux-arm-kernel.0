From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 18 Nov 2011 21:13:28 +0000
Subject: Question about unaligned memory access on ARMv7
References: <4EC6C0F7.5040203@gmail.com>
Message-ID: <yw1x4ny15e2v.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haohui Mai <haohui.mai@gmail.com> writes:

> Hi,
>
> My linux kernel complained about the user space binaries doing unaligned
> memory access.
>
> Here is one of the log:
>
> [ 1056.522396] Alignment trap: rsyslogd (1400) PC=0x4004450e
> Instr=0xe8541f00 Address=0x409f84f5 FSR 0x001

That is an LDREX instruction.  It does not support unaligned addresses.

> $ echo "0xe8 0x54 0x1f 0x00"|/opt/local/ibos/bin/llvm-mc --disassemble
> -triple=thumb-apple-darwin9
>     strb    r0, [r5, r3]
>     movs    r7, r3

You got the byte order wrong there.

> Any suggestions are appreciated.

Fix your application.

-- 
M?ns Rullg?rd
mans at mansr.com
