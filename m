From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 24 Oct 2013 13:33:59 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024095232.27BBCC4039D@trevor.secretlab.ca>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
Message-ID: <1382614439.6040.16.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-10-24 at 10:52 +0100, Grant Likely wrote:

> At this point if the hardware exists then it should be described in DTB,
> even if it is merely compatible, reg, interrupts and maybe clocks

if your driver does not use them, chances are you'll get them wrong.

> properties. In many cases that is all that is required. It /is/ okay to
> amend a binding later and to use default values if the new properties
> aren't present.

how do you handle the case of a wrong property, because you only wrote
hardware description and not the driver ?

> hardware description when enabling previously unused peripherals, but it
> is absolutely not friendly to change a binding/driver in a what that fails on
> previously working DTB (with the caveat that if no one notices, it
> isn't breakage).

ok then how do we solve that case:

 - Marvell SOC 1 is mainlined
 - Marvell SOC 2 is mainlined
 - Marvell SOC 'x' is mainlined
 - "PIO" hw crypto driver is written, working for all SOCs
 - [1 year]
 - SOCs bindings are marked as stable
 - [1 year]
 - someone rewrite the driver of hw crypto to use DMA, existing binding
is not ok because clock 'foo' or interrupt 'bar', now required, are not
present.

what is the process merge that driver ?

if the answer is that you need to keep PIO mode in driver so that
existing DTBs still works with it, then this is just plain *wrong*.

-- 
Maxime
