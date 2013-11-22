From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Nov 2013 14:05:19 +0000
Subject: [PATCHv4] ASoC: Add support for BCM2835
In-Reply-To: <528F5CE3.30105@koalo.de>
References: <528E4E4A.20403@koalo.de>
 <528F5CE3.30105@koalo.de>
Message-ID: <20131122140519.GN14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 02:32:19PM +0100, Florian Meier wrote:
> > +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev),
> > +			   GFP_KERNEL);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);

> Found a typo here, should be IS_ERR(dev) and PTR_ERR(dev).

No, it should be a check for NULL and returning -ENOMEM.

> Is the patch acceptable apart from that now?

Not looked yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/c9136bce/attachment.sig>
