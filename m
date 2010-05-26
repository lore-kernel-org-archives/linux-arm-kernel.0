From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 26 May 2010 21:13:37 +0200
Subject: [PATCH 7/17] arch/arm/common: Add missing spin_unlock_irqrestore
In-Reply-To: <20100526184358.GC6232@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1005261756000.23743@ask.diku.dk>
	<201005261907.06198.marek.vasut@gmail.com>
	<20100526184358.GC6232@n2100.arm.linux.org.uk>
Message-ID: <201005262113.38450.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 26. kv?tna 2010 20:43:58 Russell King - ARM Linux napsal(a):
> On Wed, May 26, 2010 at 07:07:06PM +0200, Marek Vasut wrote:
> > Why are "readl"s protected by spinlock anyway ? Can't we just move the
> > locking past the code above ?
> 
> Good question - and there seems to be a deadlock waiting to happen -
> sa1111_wake() re-takes the same lock.
> 
> I think we should kill all the spinlock in sa1111_resume().

Russell, Julia, check the patch I posted. Comments are welcome.

btw. Russell, killing the spinlock in resume might be overkill. If there was any 
reason for that being there, it was for the write ops so I'd rather keep those 
locked. Anyone with actual hardware available should look into that though.
