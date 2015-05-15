From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 May 2015 10:25:43 +0100
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1431675522.2128.13.camel@mhfsdcap03>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431675522.2128.13.camel@mhfsdcap03>
Message-ID: <20150515092543.GY2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 03:38:42PM +0800, leilk liu wrote:
> On Tue, 2015-05-12 at 17:05 +0100, Mark Brown wrote:

> > Implement can_dma() - look for drivers providing that for examples.

> MTK spi hardware uses the dmaengine in spi controller. According to
> datasheet, spi driver just need to enable dma register bit and write a
> physical address to relevant dma address register, so I think it may be
> complex while the driver supports can_dma.

That's how a very large proportion of devices that work with DMA are
done - why would this be complicated?  All can_dma() does is report if
DMA is possible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/9e13e48a/attachment.sig>
