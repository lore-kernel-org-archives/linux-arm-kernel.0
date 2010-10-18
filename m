From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 18 Oct 2010 16:33:03 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
	<AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
Message-ID: <1287412383.29097.1603.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 16:28 +0200, Ohad Ben-Cohen wrote:
> On Mon, Oct 18, 2010 at 3:43 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Right, so the problem is that there simply is no way to do atomic memory
> > access from these auxiliary processing units wrt the main CPU?
> 
> Yes. There are a few relevant system-wide limitations, one of them is
> that simply the system interconnect does not support those fancy
> atomic operations.

Does it support full memory coherency though? Otherwise I can see memory
based message passing becoming rather interesting.

Without coherency everybody needs to be damn sure to flush the relevant
bits before unlocking and such.
