From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 20 Apr 2010 03:03:52 +0200
Subject: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9@mail.gmail.com>
References: <20100412213235.1688dda8@hyperion.delvare>
	<1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
	<z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9@mail.gmail.com>
Message-ID: <20100420010352.GB19957@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 08:20:46AM +0800, Eric Miao wrote:
> On Sun, Apr 18, 2010 at 7:48 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > The timeout value is in jiffies, so it should be using HZ, not a plain
> > number. Assume with HZ=100 '100' means 1s here and adapt accordingly.
> >
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Marc Zyngier <maz@misterjones.org>
> > Cc: Paul Shen <paul.shen@marvell.com>
> > Cc: Mike Rapoport <mike@compulab.co.il>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > ---
> >
> > Changes since V1:
> >
> > * Don't assume 100 means 100ms
> >
> > Thanks for the comments!
> >
> > Admitted, the first try was a really bad guess. Maybe I got distracted from the
> > previous patch for another arch where the value was 10000.
> >
> > While this may still not be the favoured solution for Eric, I think it is at
> > least better than before, so it might be worth applying after all?
> 
> Ack. The clearest fix would involve more code to be updated, which
> can be postponed. This fix, at least, makes the time quantity clearer.

Thanks. Can you pick it up? Because it is a change to a board-file.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100420/8019b103/attachment.sig>
