From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 12:16:07 +0200
Subject: [PATCH v3 0/8] i2c: at91: cleanup and dt support
In-Reply-To: <505041EF.5060204@atmel.com>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
 <505041EF.5060204@atmel.com>
Message-ID: <20120912101607.GA2624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 10:03:59AM +0200, Nicolas Ferre wrote:
> On 09/12/2012 08:42 AM, ludovic.desroches at atmel.com :
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Hi,
> > 
> > This set of patches is based on Nikolaus at91_i2c driver.
> > 
> > Changes:
> > v3:
> >   - only put multi-drive lines in the if...else statement (suggested
> >   by Warner Losh)
> 
> Hi Wolfram,
> 
> As said by Ludovic, this series goes on top of Nikolaus' one.
> My Acked-by is already set on this one, so I think that I have nothing
> more to do ;-)
> 
> BTW, in case you need help to sort all this, do not hesitate to contact
> us... we can setup a git tree for this...

I think I am fine. Patches look good. I wondered a bit about first
removing the old driver, then adding the new one with regard to
bisectability. But as the old driver depends on BROKEN, I think this is
OK to do.

One thing I'd like to make, though. I'd like to squash the following
patches into one:

	drivers/i2c/busses/i2c-at91.c: add new driver
	i2c: at91: use managed resources
	i2c: at91: add warning about transmission issues for some devices
	i2c: at91: use an id table for SoC dependent parameters

It is especially the last patch I am mostly interested in. The id_table
approach is what I like, while the original id_entry mechanism looks
fishy. I'd was good for reviewing to have the patches split like this;
yet for hitting mainline, I'd prefer to have the driver proper on first
occasion. I already did the squashing in a test-branch and the result
looks good to me.

Nikolaus, Ludovic: Are you fine with this?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/f3eb127a/attachment.sig>
