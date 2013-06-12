From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 12 Jun 2013 17:10:37 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306121008420.1431-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306121008420.1431-100000@iolanthe.rowland.org>
Message-ID: <1757819.Rmlin4PoBK@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 10:35:44 Alan Stern wrote:
> On Wed, 12 Jun 2013, Ming Lei wrote:
> 
> > If not, I am wondering why one USB driver need register another hard
> > interrupt handler? Could you share such examples? I understand the
> > case only exists with timer handler as discussed with Oliver, don't I?
> 
> Here's another possibility.  A USB driver has a private lock, and it
> acquires this lock in its completion handler.  But it also acquires
> this lock in other routines, and those other routines may be called by
> other drivers or subsystems in interrupt context.

That is fatal. But again mechanically using _irqsave in complete()
does the job. No other place can be affected.

	Regards
		Oliver
