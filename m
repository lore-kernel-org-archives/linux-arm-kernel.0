From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 24 Sep 2012 15:00:23 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <alpine.DEB.2.00.1209242142490.4521@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <alpine.DEB.2.00.1209211740170.8839@utopia.booyaka.com>
 <20120921212054.GE2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209212240190.31812@utopia.booyaka.com>
 <20120922000537.GH2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221813330.10663@utopia.booyaka.com>
 <20120922195253.GD2934@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209222214120.22590@utopia.booyaka.com>
 <20120922231733.GI2934@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209242142490.4521@utopia.booyaka.com>
Message-ID: <20120924220023.GG2477@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 09:54:00PM +0000, Paul Walmsley wrote:
> On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> 
> > On Sat, Sep 22, 2012 at 10:20:19PM +0000, Paul Walmsley wrote:
> > > On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> > >
> > > > This thing has been in the kernel since about 2004, not sure why you 
> > > > didn't hit it earlier.
> > > 
> > > One other data point in that regard - noticed the warnings don't appear 
> > > when the board is booted with:
> > > 
> > > commit 4fa3b6cb1bc8c14b81b4c8ffdfd3f2500a7e9367
> > > Author: Paul E. McKenney <paul.mckenney@linaro.org>
> > > Date:   Tue Jun 5 15:53:53 2012 -0700
> > > 
> > >     rcu: Fix qlen_lazy breakage
> > 
> > You lost me on this one.  This is already in mainline, so if you were
> > using (say) 3.6-rc6, you would already have this commit applied.
> 
> If I check out a kernel at this commit 
> 4fa3b6cb1bc8c14b81b4c8ffdfd3f2500a7e9367 + the 
> zero-callback-in-tickless-idle diagnostic patch, build and boot it, then 
> the stall warnings don't appear (in 25 minutes of testing).
> 
> Messages from the diagnostic patch indicate that the kernel is entering 
> idle during a grace period with no RCU callbacks, though.
> 
> This is not a big deal and does not need any further attention.  Just 
> wanted to place a time boundary on the point when these messages started 
> appearing.  (It is unlikely to be an optimal bound: i.e., there are 
> probably later commits where the warnings also don't appear.)

Ah, got it, thank you!

							Thanx, Paul
