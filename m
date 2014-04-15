From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 14:50:06 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415.143054.770827409393483803.davem@davemloft.net>
References: <20140415.134627.1895466146177627985.davem@davemloft.net>
 <20140415180311.GA11690@redhat.com>
 <20140415.143054.770827409393483803.davem@davemloft.net>
Message-ID: <20140415.145006.2299301203857235456.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Tue, 15 Apr 2014 14:30:54 -0400 (EDT)

> Russell, if for example userland stores into the instruction stream
> to patch an instruction, what needs to be done on ARM?

Looking around I suspect something like:

	mcrne	p15, 0, INSN_ADDR, c7, c5, 1

after the instruction stores will do it.
