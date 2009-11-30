From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 30 Nov 2009 18:02:04 +0100
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <20091126090252.GB12179@pengutronix.de>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
	<20091126090252.GB12179@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
> clocking
> 
> Hello,
> 
> can you please add something like "i2c-pnx: " to the subject?
> (Actually it's a great strategy *not* to put it into the Subject.  This
> way it attracts far more attention :-)
> 

Good point!

> > Remove suspend/resume functionality, I2C driver gates clock on
> > only when an I2C transaction is in progress
> What happens when the machine suspends while a transfer is in progress?
> (This might be a problem that already existed before.)  If this is
> really a problem the easiest "fix" is to let the suspend callback return
> -EBUSY in this case.

The suspend callback is now removed. It's actually not needed with this
change. The I2C clocks will turn on prior to a transaction and then turn
off at the completion.

> 
> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                              | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                    | http://www.pengutronix.de/
> |
