From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Sun, 01 Dec 2013 20:46:19 +0100
Subject: Support for KGDB/gdb data watchpoints in ARM kernel?
Message-ID: <529B920B.1000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I've been trying to use KGDB with gdb to debug an ARM Linux kernel. Setting breakpoints at functions works fine, but
whenever I try to set a data watchpoint to make the debugger/system stop when a certain variable/memory location is
modified gdb says 'Could no insert hardware watchpoint 2.'. Although I don't have any other watchpoints/breakpoints
enabled at this time, unless there's something going on under the hood.

I've tried with Kernel 3.12 on i.MX31 (ARM1136) and i.MX53 (Cortex-A8) using both gdb 7.6.1 compiled from sources and
gdb 7.2 from Sourcery CodeBench 2011.09-70.

Any ideas, comments or RTFMs are welcome to enlighten me!


(gdb) watch *(0x8000d300)
Hardware watchpoint 2: *(0x8000d300)

(gdb) c
Continuing.
Warning:
Could not insert hardware watchpoint 2.
Could not insert hardware breakpoints:
You may have requested too many hardware breakpoints/watchpoints.

(gdb) info b
Num     Type           Disp Enb Address    What
2       hw watchpoint  keep y              *(0x8000d300)

Regards, Magnus Lilja
