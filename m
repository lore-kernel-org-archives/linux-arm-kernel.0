From: rabin@rab.in (Rabin Vincent)
Date: Sat, 9 Oct 2010 23:20:50 +0530
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
In-Reply-To: <20100306201849.GD13262@n2100.arm.linux.org.uk>
References: <4B91A39F.8050502@am.sony.com>
	<20100306201849.GD13262@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 7, 2010 at 1:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
>> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
>> a compiler error on kernel/trace/trace_functions_graph.c),
>> although no routines were marked as __irq_entry.
>
> Well, ARM already places the assembly exception text in its own separate
> section for other reasons. ?We can't place it in two sections.
>
> What is __irq_entry used for? ?Just the low level assembly or C functions?

It's used just for the C entry functions for interrupts: asm_do_IRQ()
and the IPI and local timer functions.

AFAICS __exception seems to be used only for is_exception_text().  If
that's the case, would it be OK to just place those functions in
__irq_entry if ftrace is built and have is_exception_text() check that
section too?
