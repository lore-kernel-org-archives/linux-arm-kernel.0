From: marex@denx.de (Marek Vasut)
Date: Sat, 28 Apr 2012 15:33:35 +0200
Subject: [PATCH] i2c: mxs: disable QUEUE when sending is done
In-Reply-To: <20120428102601.GO20039@pengutronix.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
 <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
 <20120428102601.GO20039@pengutronix.de>
Message-ID: <201204281533.35277.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Uwe Kleine-K?nig,

> On Fri, Apr 27, 2012 at 11:51:56AM -0300, Fabio Estevam wrote:
> > Hi Wolfram,
> > 
> > On Fri, Apr 27, 2012 at 11:23 AM, Wolfram Sang <w.sang@pengutronix.de> 
wrote:
> > >        if (i2c->cmd_err == -ENXIO)
> > >                mxs_i2c_reset(i2c);
> > > +       else
> > > +               writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
> > > +                               i2c->regs + MXS_I2C_QUEUECTRL_CLR);
> > 
> > When setting the QUEUE_RUN, do we really want to clear all the other
> > bits of QUEUECTRL_CLR register?
> > 
> > I am wondering if we should only set QUEUE_RUN bit here.
> 
> I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
> just clears the QUEUE_RUN bit and nothing else?!

I think the RUN bit will be cleared by the controller anyway, so this patch is 
pointless.

> 
> Best regards
> Uwe

Best regards,
Marek Vasut
