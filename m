From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 29 Apr 2012 10:43:24 +0200
Subject: [PATCH] i2c: mxs: disable QUEUE when sending is done
In-Reply-To: <201204281533.35277.marex@denx.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
 <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
 <20120428102601.GO20039@pengutronix.de>
 <201204281533.35277.marex@denx.de>
Message-ID: <20120429084324.GA3001@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > I am wondering if we should only set QUEUE_RUN bit here.
> > 
> > I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
> > just clears the QUEUE_RUN bit and nothing else?!
> 
> I think the RUN bit will be cleared by the controller anyway, so this patch is 
> pointless.

How do you get this idea? Given 27.3.2 and our experiences, I'd be very
surprised. Try putting the system under heavy load without this patch
and you'll see that FIFOs might be sent half filled when interrupted
while filling.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/67ca761f/attachment.sig>
