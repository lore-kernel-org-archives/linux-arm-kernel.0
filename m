From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 22:13:15 +0000
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <201401142302.31434.marex@denx.de>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
 <201401142238.32262.marex@denx.de>
 <20140114215548.GD15567@sirena.org.uk>
 <201401142302.31434.marex@denx.de>
Message-ID: <20140114221315.GE15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:02:31PM +0100, Marek Vasut wrote:
> On Tuesday, January 14, 2014 at 10:55:48 PM, Mark Brown wrote:

> > Or try to - the other trick here is getting 4MB of contiguous memory in
> > the first place (unless there's an IOMMU making everything pretty).

> Oh, but what if I want to make a really looong transfer ? Say, read entire SPI 
> NOR of 128MB in size ... Spansion has such big SPI NORs in their new portfolio.

Use scatter/gather - to the SPI controller and the outside world it
still looks like one big transfer (I'm missing a way to go from a
virtual address to a sg_list, that'd be handy).  It's an issue if the
DMA controller doesn't support it but but that's rare.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/5a63d036/attachment.sig>
