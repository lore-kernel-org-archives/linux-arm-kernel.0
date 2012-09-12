From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 13:51:43 +0200
Subject: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
In-Reply-To: <50502AE3.7040300@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
 <20120911215112.GA27031@pengutronix.de> <50502AE3.7040300@ti.com>
Message-ID: <20120912115143.GE2624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:55:39AM +0530, Shubhrajyoti wrote:
> On Wednesday 12 September 2012 03:21 AM, Wolfram Sang wrote:
> >> -omap_i2c_isr(int this_irq, void *dev_id)
> >> > +omap_i2c_isr(int irq, void *dev_id)
> >> >  {
> >> >  	struct omap_i2c_dev *dev = dev_id;
> >> > +	irqreturn_t ret = IRQ_HANDLED;
> > Shouldn't that be IRQ_NONE?
> Actually we are processing it so I thought it to be ok.

Are we processing it? There is nothing acknowledged AFAICS. Anyway, we
can fix that with a later patch.

> Also a similar discussion.
>  
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104422.html

I totally agree to the things said there.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/12939203/attachment-0001.sig>
