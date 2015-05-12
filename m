From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 17:05:40 +0100
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1431434356.2128.9.camel@mhfsdcap03>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
Message-ID: <20150512160540.GB3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 08:39:16PM +0800, leilk liu wrote:
> On Fri, 2015-05-08 at 18:53 +0100, Mark Brown wrote:
> > On Fri, May 08, 2015 at 04:55:42PM +0800, leilk.liu at mediatek.com wrote:

> Could you tell me more details about "You should also be using the core
> helpers for DMA mapping"?

Implement can_dma() - look for drivers providing that for examples.

> > > +static const struct of_device_id mtk_spi_of_match[] = {
> > > +	{ .compatible = "mediatek,mt6589-spi", .data = (void *)COMPAT_MT6589},
> > > +	{ .compatible = "mediatek,mt8173-spi", .data = (void *)COMPAT_MT8173},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mtk_spi_of_match);

> > There were three compatible strings listed in the DT binding but only
> > two here.

> MT6589 and MT8135 is compatible; 
> For MT8135 IC, it can use the follow way in dts to probe:
>   compatible = "mediatek,mt8135-spi", 
> 	       "mediatek,mt6589-spi";

> And I test it's ok on MT8135 platform. So I add struct of_device_id
> mtk_spi_of_match like this in spi driver code.

You should list all the compatibles documented in the binding here, if
some of them are the same just have them map to a single constant.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/979e433c/attachment.sig>
