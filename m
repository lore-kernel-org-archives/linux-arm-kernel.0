From: mbizon@freebox.fr (Maxime Bizon)
Date: Wed, 23 Oct 2013 20:46:22 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023174458.GC5208@netboy>
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
Message-ID: <1382553982.31058.10.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2013-10-23 at 19:45 +0200, Richard Cochran wrote:
> 
> Once I design my board, and it goes into production, the hardware is
> fixed. It doesn't change, and neither should the description of the
> hardware, also known as the DTB. If I have to research all of the
> ways 

SOC support are never completely finished; subsystems are getting new
features.
 
It's possible to ship a product with a kernel version that does not
handle all the chip goodies, then want to upgrade the kernel later when
someone has written the driver for a previously unused hardware block.

the first iteration of your DTB would be incomplete, the bindings to
describe that hardware block would not exist inside it.

real life example with Marvell Kirkwood, hw crypto support was added 1
year after initial SOC support.

I'm happy I can use it now on existing boards by "just" upgrading the
kernel.

-- 
Maxime
