From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Dec 2009 11:36:08 +0100
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <083DF309106F364B939360100EC290F804F57A69FA@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
	<20091126090252.GB12179@pengutronix.de>
	<083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
	<20091206084731.GE2766@ucw.cz>
	<20091206210225.GA20887@pengutronix.de>
	<20091206210739.GE10184@elf.ucw.cz>
	<083DF309106F364B939360100EC290F804F57A69FA@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091215103608.GE17930@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > Are you sure its unneeded? What if someone attempts to suspend the
> > > > system when a transaction is running?
> > > That's exactly my question.  I think the machine will suspend and the
> > > transaction fail.  So no suspend callback isn't optimal, but maybe OK?!
> > 
> > Having failures just because suspend happened at wrong time is
> > bad. .suspend() should just wait for end of transaction.
> 
> I'm not sure what situation could actually occur that would suspend the
> system in the middle of an I2C transaction. If an I2C transaction was
> started and the CPU was suspended, this would appear to be a problem
> outside the I2C driver itself. Would other I2C drivers have this similar
> problem?

Well, can the i2c transaction sleep? If so, suspend probably can come
in the middle.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
