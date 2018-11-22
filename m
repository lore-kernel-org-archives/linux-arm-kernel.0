From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 14:58:53 +0100
Subject: [PATCH 3/5] media: sunxi: Add A10 CSI driver
In-Reply-To: <20181121220102.6nn7uwu2c67zs6pz@mara.localdomain>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
 <20181115205106.thbkojnzdwmaeui3@flea>
 <20181121220102.6nn7uwu2c67zs6pz@mara.localdomain>
Message-ID: <20181122135853.4rpxb32d6ios5zac@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Thu, Nov 22, 2018 at 12:01:03AM +0200, Sakari Ailus wrote:
> On Thu, Nov 15, 2018 at 09:51:06PM +0100, Maxime Ripard wrote:
> > Hi Hans,
> > 
> > Thanks for your review! I'll address the other comments you made.
> > 
> > On Tue, Nov 13, 2018 at 01:24:47PM +0100, Hans Verkuil wrote:
> > > > +static int csi_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct sun4i_csi *csi;
> > > > +	struct resource *res;
> > > > +	int ret;
> > > > +	int irq;
> > > > +
> > > > +	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> > > 
> > > devm_kzalloc is not recommended: all devm_ memory is freed when the driver
> > > is unbound, but a filehandle might still have a reference open.
> > 
> > How would a !devm variant with a kfree in the remove help? We would
> > still fall in the same case, right?
> 
> Not quite. For video nodes this is handled: the release callback gets called
> once there are no file handles open to the device. That may well be much
> later than the device has been unbound from the driver.

I might be missing something, but how the release callback will be
able to get the reference to the structure we allocated here so that
it can free it?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/bff95c00/attachment-0001.sig>
