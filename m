From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Nov 2018 21:51:06 +0100
Subject: [PATCH 3/5] media: sunxi: Add A10 CSI driver
In-Reply-To: <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
Message-ID: <20181115205106.thbkojnzdwmaeui3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Thanks for your review! I'll address the other comments you made.

On Tue, Nov 13, 2018 at 01:24:47PM +0100, Hans Verkuil wrote:
> > +static int csi_probe(struct platform_device *pdev)
> > +{
> > +	struct sun4i_csi *csi;
> > +	struct resource *res;
> > +	int ret;
> > +	int irq;
> > +
> > +	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> 
> devm_kzalloc is not recommended: all devm_ memory is freed when the driver
> is unbound, but a filehandle might still have a reference open.

How would a !devm variant with a kfree in the remove help? We would
still fall in the same case, right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/f7c42dde/attachment-0001.sig>
