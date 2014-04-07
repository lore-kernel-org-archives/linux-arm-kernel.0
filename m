From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Apr 2014 15:02:56 +0100
Subject: Porting plat-pxa to the MMP PDMA driver
In-Reply-To: <5342A73F.8010907@zonque.org>
References: <5342A73F.8010907@zonque.org>
Message-ID: <20140407140256.GA13237@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 03:25:19PM +0200, Daniel Mack wrote:
> On 04/07/2014 03:12 PM, Laurent Pinchart wrote:

> > I'm writing instead of the legacy PXA DMA code. However, this requires porting 
> > the platform to the MMP PDMA driver first, which involves porting all the 
> > above drivers to the DMA engine API. The spi-pxa2xx driver has already been 
> > ported and currently supports both the legacy PXA DMA API and the DMA engine 
> > API. All the other drivers seem to require the legacy PXA DMA API.

> > I was wondering if any effort had been started in that direction. I could 
> > possibly help with the pxamci driver, but not with the other drivers as the 
> > corresponding peripherals are not used on my test platform (a custom PXA27x 
> > board).

> Yes, I've started working on this a long time ago, but got stuck because
> of the lack of support from users, as I don't have hardware with all
> possible DMA-capable components in use. Have a look here, the tree
> should be easily rebasable onto newer versions:

Is it not possible to do what we're doing with the Samsung platforms and
have both platform and generic DMA code in the source, selected via a
Kconfig symbol?  That way you don't have to have a flag day.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/fa32b3aa/attachment.sig>
