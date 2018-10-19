From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 19 Oct 2018 12:17:03 +0200
Subject: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
In-Reply-To: <20181019092145.6zihrnduyypzo5x2@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-3-o.rempel@pengutronix.de>
 <20181019071243.t5bwcmnnlqrgtajj@pengutronix.de>
 <20181019090100.6vcergf6txgxt7fo@pengutronix.de>
 <20181019092145.6zihrnduyypzo5x2@pengutronix.de>
Message-ID: <20181019101703.qmgljhldymq3xtj3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 11:21:45AM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Oct 19, 2018 at 11:01:00AM +0200, Oleksij Rempel wrote:
> > On Fri, Oct 19, 2018 at 09:12:43AM +0200, Uwe Kleine-K?nig wrote:
> > > Hello Oleksij,
> > > 
> > > On Thu, Oct 18, 2018 at 01:26:14PM +0200, Oleksij Rempel wrote:
> > > > The DMA support for I2C was introduced on i.MX50. So,
> > > > avoid of DMA probing on not supported versions.
> > > 
> > > What is the obvious downside of trying to use DMA on i.MX21? If the
> > > purpose is just to suppress the message
> > > 
> > > 	can't request DMA tx channel
> > > 
> > > , that goes away with patch 3, too.
> > > 
> > > Note that if we agree that i.MX50 (and later) isn't compatible to
> > > i.MX21, all device trees should be fixed accordingly. IMHO the
> > > difference "There is a DMA engine connected only on some
> > > implementations" doesn't give enough incentive to claim that i.MX21 and
> > > i.MX50 must not share the compatible.
> > 
> > I don't see any sense to do allocation and add extra probes just to find
> > what we already know from compatible.
> 
> I think it's perfectly fine to only notice that there is no DMA support
> when trying to set it up. It has slight runtime overhead, yes, but being
> able to handle imx21 and imx50 in the same way is a nice advantage that
> I don't want to throw away easily.
> 
> If you care about the allocation, you can do do the calls to
> dma_request_chan first and assign to local variables before the
> allocation of *dma.

Ok, then we can drop this patch.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181019/37dc7490/attachment.sig>
