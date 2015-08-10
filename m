From: caschebe@techfak.uni-bielefeld.de (Christian Ascheberg)
Date: Mon, 10 Aug 2015 19:49:11 +0200
Subject: Problem with ftrace uprobes on ARM
Message-ID: <55C8E417.7080607@techfak.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I want to trace a program using ftrace uprobes on an Altera Cyclone V 
SoC board which has a ARMv7 processor, but I cannot get it to work. 
Every source I read says that uprobes should be supported on ARM.
So I hope that this is the right place to ask this question. I tried 
different kernel versions from Altera and github.com/torvalds/linux/, 
including 4.0, 4.1 and the latest 4.2-RC6.
The Linux config is the default socfpga_defconfig plus 
CONFIG_UPROBE_EVENT=y. Can somebody tell me if support should be 
available as I expect? These are the commands that I tried:

# objdump -t benchmark | grep "calc_sum"
00008574 g     F .text    00000020              calc_sum

# echo 'p /home/root/benchmark:0x8574' > 
/sys/kernel/debug/tracing/uprobe_events

# echo 1 > 
/sys/kernel/debug/tracing/events/uprobes/p_benchmark_0x8574/enable
-sh: echo: write error: Invalid argument

So the probe point is registered, but I cannot enable it. dmesg tells me 
the same without providing any more details.
I tried to do the same using Perf but it crashed my program, presumably 
when hitting the probe point.

Thanks
Christian
