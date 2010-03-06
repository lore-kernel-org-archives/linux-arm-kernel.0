From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Mar 2010 20:18:49 +0000
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
In-Reply-To: <4B91A39F.8050502@am.sony.com>
References: <4B91A39F.8050502@am.sony.com>
Message-ID: <20100306201849.GD13262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
> a compiler error on kernel/trace/trace_functions_graph.c),
> although no routines were marked as __irq_entry.

Well, ARM already places the assembly exception text in its own separate
section for other reasons.  We can't place it in two sections.

What is __irq_entry used for?  Just the low level assembly or C functions?
