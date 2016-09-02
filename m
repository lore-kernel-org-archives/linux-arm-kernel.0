From: james.morse@arm.com (James Morse)
Date: Fri, 02 Sep 2016 11:56:39 +0100
Subject: [PATCH V2] arm64:ftrace: add save_stack_trace_regs()
In-Reply-To: <57C95967.9030308@arm.com>
References: <4f7d7a6bff7f06f814bf9a2bdc90bb0e3b833b66.1472734699.git.panand@redhat.com>
 <57C95967.9030308@arm.com>
Message-ID: <57C95AE7.5030104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/16 11:50, James Morse wrote:
> Hi Pratyush,
> 
> On 01/09/16 14:35, Pratyush Anand wrote:
>> Implement save_stack_trace_regs, so that stacktrace of a kprobe events can be
>> obtained.
> 
> Hmm, kconfig enables 'CONFIG_KPROBE_EVENT' if we select KPROBES and FTRACE, this
> calls save_stack_trace_regs(), which we haven't implemented, giving:
> [  373.406982] save_stack_trace_regs() not implemented yet.
> [  373.413020] ------------[ cut here ]------------
> [  373.417601] WARNING: CPU: 1 PID: 0 at ../kernel/stacktrace.c:74 save_stack_tr
> ace_regs+0x3c/0x48
> [  373.426212] Modules linked in:
> [  373.429238]
> [  373.430716] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0-rc4-dirty #5128
> [  373.437606] Hardware name: ARM Juno development board (r1) (DT)
> [  373.443466] task: ffff800975dd1900 task.stack: ffff800975ddc000
> [  373.449327] PC is at save_stack_trace_regs+0x3c/0x48
> [  373.454242] LR is at save_stack_trace_regs+0x3c/0x48
> [  373.459156] pc : [<ffff000008126c64>] lr : [<ffff000008126c64>] pstate: 600003c5
> [  373.466476] sp : ffff80097ef52c00
> 
> [  373.554836] Call trace:
> [  373.641153] [<ffff000008126c64>] save_stack_trace_regs+0x3c/0x48
> [  373.647104] [<ffff00000817a0b0>] __ftrace_trace_stack+0x168/0x208
> [  373.653138] [<ffff00000817ad40>] trace_buffer_unlock_commit_regs+0x5c/0x7c
> [  373.659946] [<ffff00000818d57c>] kprobe_trace_func+0x308/0x3d8
> [  373.665721] [<ffff00000818defc>] kprobe_dispatcher+0x58/0x60
> [  373.671327] [<ffff0000088d8cfc>] kprobe_breakpoint_handler+0xbc/0x18c
> [  373.677705] [<ffff0000080851b8>] brk_handler+0x50/0x90
> [  373.682792] [<ffff000008081300>] do_debug_exception+0x50/0xbc
> 
> 
> I guess hitting a WARN_ONCE() while using a 'kernel hacking' feature isn't
> serious enough to make this a fix.
> 

I wasn't clear enough with the above: this patch is fixing this WARN_ON(), it
may be worth mentioning that in the commit message...



Thanks,

James
