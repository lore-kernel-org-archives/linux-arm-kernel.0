From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jul 2010 00:11:28 +0100
Subject: [PATCH] ARM: Stop secondary cpus in machine_halt()
In-Reply-To: <20100701224706.GA26473@lixom.net>
References: <20100701224706.GA26473@lixom.net>
Message-ID: <20100701231128.GA19906@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 05:47:06PM -0500, Olof Johansson wrote:
> ARM doesn't spin down secondary cpus on halt, which results in interrupts
> being delivered even after the "System halted" message, etc.
> 
> Change that to use smp_send_stop() to halt them. Also, change the
> smp_send_stop() on ARM to not do a stack dump when stopping.

Actually, we want stack dumps - sometimes.  For instance, when we
panic() or similar.
