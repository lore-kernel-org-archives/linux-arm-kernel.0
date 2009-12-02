From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 2 Dec 2009 17:04:00 +0100
Subject: strange, spurious seeming vector exception on pxa300
In-Reply-To: <20091202155057.GA30669@n2100.arm.linux.org.uk>
References: <4B159524.2020408@comrex.com>
	<f17812d70912012200m4532317eue21baf5e10925455@mail.gmail.com>
	<f17812d70912012207x28178b1bh98fbf560b6da536@mail.gmail.com>
	<4B167C69.6060903@comrex.com>
	<20091202155057.GA30669@n2100.arm.linux.org.uk>
Message-ID: <20091202160400.GE14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 03:50:57PM +0000, Russell King - ARM Linux wrote:
> > r12            0x401d6c20    1075670048
> > sp             0x412c8a2c    0x412c8a2c
> > lr             0x4029603c    1076453436
> > pc             0x400ec47c    0x400ec47c <f1+172>
> > fps            0x0    0
> > cpsr           0x60000010    1610612752
> 
> CPSR says NZCV=0110 (zero, carry).  32-bit user mode.
> 
> Given that the conditions are clearly wrong for a vector exception, I would
> say that you're hitting some kind of hardware bug - maybe caused by a dirty
> power supply to the PXA, causing it to misbehave?

We've had trouble of that kind as well some month ago with an early
prototype. It wasn't an exception we got, but the bug was clearly
hitting the same code path every single time, so this issue might be
related. Eventually it went away with new board revision which made wire
patching around the DDR SDRAM unnecessary (i.e, cleaner signal pathes).

Strange enough, I would have expected such flaws to cause processor
misbeviour of all sorts, totally random and unpredictable. The fact that
is was the same function we always ended up in is still some kind of
miracle I can't explain.

Daniel
