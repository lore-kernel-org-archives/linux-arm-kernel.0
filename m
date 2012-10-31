From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 09:27:56 -0700
Subject: [PATCH] fix DEBUG_LL DCC race condition
In-Reply-To: <20121029151832.GA2162@sig21.net>
References: <20121029151832.GA2162@sig21.net>
Message-ID: <20121031162754.GE12739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johannes Stezenbach <js@sig21.net> [121029 08:20]:
> Trying to boot a kernel with I- and D-caches disabled
> sometimes hangs when DEBUG_LL output to DCC is enabled.
> Apparently the JTAG debugger sometimes reads the
> DCC register before busyuart could see the wDTRfull flag,
> thus busyuart spins in an endless loop.
> 
> The reason seems to be a misunderstanding of the purpose
> of the busyuart macro.  For UART, waituart waits until
> there is space in the FIFO, and busyuart waits until
> the FIFO is empty (all data is sent).
> For DCC, busyuart should be identical to waituart since
> there is no FIFO.
> 
> Signed-off-by: Johannes Stezenbach <js@sig21.net>
> ---
> Only tested on ARMv6.
> e.g. arch/arm/mach-at91/include/mach/debug-macro.S has some
> comments which clarify what busyuart is supposed to be doing.

Your explanation makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>
