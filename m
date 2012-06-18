From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Jun 2012 10:43:00 +0200
Subject: Dove clock support (was: Re: RFC: [PATCH] ARM: Kirkwood:
 clk_register_gate_fn: add fn assignment)
In-Reply-To: <4FDEE6C6.2060101@blackshift.org>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
Message-ID: <20120618084300.GL4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sure, the address layout is different, but that can be made generic in a
> second step. Maybe we need a private pointer in the gate_fn struct.

Yes, something like that.
 
> BTW: who will enable the clocks that have been disabled via the
> sata/pcie shutdown functions?

This is potentially a problem when the SATA driver is built as a
kernel module. There is no code that i know of to turn the SATA PHYs
back on again. I think this has been broken like this for a long
time...

For PCIE it is not a problem, that code cannot be build as a module.

    Andrew
