From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 22 Aug 2017 08:26:37 -0700
Subject: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
In-Reply-To: <1503391892.3629.28.camel@abdul.in.ibm.com>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
 <20170821.135504.1392954698746959868.davem@davemloft.net>
 <20170822084911.00000c23@huawei.com>
 <1503391892.3629.28.camel@abdul.in.ibm.com>
Message-ID: <20170822152637.GA11320@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 02:21:32PM +0530, Abdul Haleem wrote:
> On Tue, 2017-08-22 at 08:49 +0100, Jonathan Cameron wrote:
> > On Mon, 21 Aug 2017 13:55:04 -0700
> > David Miller <davem@davemloft.net> wrote:
> > 
> > > From: Nicholas Piggin <npiggin@gmail.com>
> > > Date: Tue, 22 Aug 2017 00:19:28 +1000
> > > 
> > > > Thanks here's an updated version with a couple more bugs fixed. If
> > > > you could try testing, that would be much appreciated.  
> > > 
> > > I'm not getting RCU stalls on sparc64 any longer with this patch.
> > > 
> > > I'm really happy you guys were able to figure out what was going
> > > wrong. :-)
> > > 
> > > Feel free to add my Tested-by:
> > > 
> > 
> > Like wise - 16 hours of clean run with the latest
> > 
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Thanks for all the hard work everyone put into this one, great to
> > cross it off the list!
> > 
> > Jonathan
> > 
> 
> No more RCU stalls on PowerPC, system is clean when idle or with some
> test runs.
> 
> Thank you all for your time and efforts in fixing this.
> 
> Reported-and-Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

I am still seeing failures, but then again I am running rcutorture with
lots of CPU hotplug activity.  So I am probably seeing some other bug,
though it still looks a lot like a lost timer.

							Thanx, Paul
