From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 14:27:56 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104291413550.3005@ionos>
References: <20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110429104951.GG5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291302420.3005@ionos>
	<20110429113823.GK5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291413550.3005@ionos>
Message-ID: <20110429132756.GM5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:19:25PM +0200, Thomas Gleixner wrote:
> The per clk locking is not going to work ever except you want to have
> the trylock dance if you need to propagate changes up the tree and
> down the tree. So yes, we need per tree locking and I can see the need
> for the mutex and the spinlock to protect the tree, but you really
> want to have the logic dealing with those locks and how they both
> protect the tree in common code and not in some random place.

rotfl.  "per tree locking".  That's farsical when you have muxes which
select between different distinct trees.  That _surely_ is the path to
locking mayhem, because the child clocks can have their lock changed
beneath them as the mux changes its parent.

I still think you're in a different universe.
