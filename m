From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 17:32:07 +0200
Subject: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
In-Reply-To: <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
Message-ID: <20180820153207.xx5outviph7ec76p@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> > There is also a patch series from Maxime Ripard that's addressing the
> > same general area. See "dt-bindings: Add a dma-parent property". We
> > don't need multiple ways to address describing the device to memory
> > paths, so you all had better work out a common solution.
> 
> Looks like this fits exactly into the interconnect API concept. I see
> MBUS as interconnect provider and display/camera as consumers, that
> report their bandwidth needs. I am also planning to add support for
> priority.

Thanks for working on this. After looking at your serie, the one thing
I'm a bit uncertain about (and the most important one to us) is how we
would be able to tell through which interconnect the DMA are done.

This is important to us since our topology is actually quite simple as
you've seen, but the RAM is not mapped on that bus and on the CPU's,
so we need to apply an offset to each buffer being DMA'd.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/66f72c97/attachment.sig>
