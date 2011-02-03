From: tim.bird@am.sony.com (Tim Bird)
Date: Thu, 3 Feb 2011 15:42:27 -0800
Subject: Question about ARM function graph tracing
Message-ID: <4D4B3D63.4090207@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vincent,

I sheepishly admit that I haven't been following mainline very
well.  I was happily surprised to see you have mainlined ARM
function graph tracing.  I gave it a test on my old OMAP
OSK board, with the results shown below.

My quick questions, before I dive into this, are:
1) what targets did you test with?
2) Did you test with and without dynamic tracing?
3) what version of compiler did you use?

I'm just checking, to narrow down the search space for
debugging through this.

Thanks,
 -- Tim


Kernel is version 2.6.38-rc3

I compiled the kernel with:
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_RCU_TRACE is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_TRACEPOINTS=y
CONFIG_STACKTRACE=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_GENERIC_TRACER=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set

The kernel compiles and runs.  Function tracing works OK

Function graph tracing hangs the kernel, when it is enabled:

/debug/tracing # echo function_graph >current_tracer
Unable to handle kernel NULL pointer dereference at virtual address 0000033c
pgd = c1a4e578
[0000033c] *pgd=0000033c
Unable to handle kernel paging request at virtual address b0000000
pgd = c1a4e578
[b0000000] *pgd=c1a51210
Unable to handle kernel paging request at virtual address 71a51000
pgd = c1a4e578
[71a51000] *pgd=00000001
Unable to handle kernel paging request at virtual address b0000144
pgd = c1a4e578
[b0000144] *pgd=c1a51210
Unable to handle kernel paging request at virtual address 71a51000
pgd = c1a4e578
[71a51000] *pgd=00000001
Unable to handle kernel paging request at virtual address b0000144
pgd = c1a4e578
...

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Network Entertainment
=============================
