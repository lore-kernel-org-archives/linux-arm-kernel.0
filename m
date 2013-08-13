From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 21:29:41 +0100
Subject: [PATCH 10/18] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <1686992.nQEd3xdoHn@flatron>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <20130813185547.GD6427@sirena.org.uk>
 <20130813201816.GG6427@sirena.org.uk> <1686992.nQEd3xdoHn@flatron>
Message-ID: <20130813202941.GH6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 10:20:19PM +0200, Tomasz Figa wrote:
> On Tuesday 13 of August 2013 21:18:16 Mark Brown wrote:

> > 	if (dev->chancnt > 1 && !dma_has_cap(DMA_PRIVATE, dev->cap_mask))
> > 		list_for_each_entry(chan, &dev->channels, device_node) {
> > 			/* some channels are already publicly allocated */
> > 			if (chan->client_count) {

> > which is happening because dma1chan0 (which is on the same DMA
> > controller as the SPI controller) and in fact every other DMA channel
> > had references grabbed by the network stack dmaengine helpers which I'd
> > enabled in config.  The fact that they do that is unhelpful, it renders
> > the API mostly useless, but is nothing to do with this series.

> I believe you just found another brokenness of current DMA channel 
> matching.

Yeah, at first glance the reference grabbing thing seems a bit peculiar.
I didn't research why it's done that way yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/42e6f326/attachment.sig>
