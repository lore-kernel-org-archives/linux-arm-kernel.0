From: marex@denx.de (Marek Vasut)
Date: Sun, 29 Apr 2012 11:11:13 +0200
Subject: [PATCH] i2c: mxs: disable QUEUE when sending is done
In-Reply-To: <20120429084324.GA3001@pengutronix.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
 <201204281533.35277.marex@denx.de> <20120429084324.GA3001@pengutronix.de>
Message-ID: <201204291111.13333.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > > I am wondering if we should only set QUEUE_RUN bit here.
> > > 
> > > I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
> > > just clears the QUEUE_RUN bit and nothing else?!
> > 
> > I think the RUN bit will be cleared by the controller anyway, so this
> > patch is pointless.
> 
> How do you get this idea? Given 27.3.2 and our experiences, I'd be very
> surprised. Try putting the system under heavy load without this patch
> and you'll see that FIFOs might be sent half filled when interrupted
> while filling.

All right, I won't argue here ;-)

Best regards,
Marek Vasut
