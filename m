From: Hui.Liu@freescale.com (Liu Jason)
Date: Wed, 11 Nov 2015 10:06:48 +0000
Subject: [PATCH 1/1] dmaengine: imx-sdma: remove __init annotation on
 sdma_event_remap
In-Reply-To: <4267122.WHg3VAy8bL@wuerfel>
References: <1447233649-21464-1-git-send-email-r64343@freescale.com>
 <4267122.WHg3VAy8bL@wuerfel>
Message-ID: <DM2PR0301MB121329F0B68A9D0D00F9A7B9F3130@DM2PR0301MB1213.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, November 11, 2015 6:02 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Liu Hui-R64343; dmaengine at vger.kernel.org; vinod.koul at intel.com;
> dan.j.williams at intel.com; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 1/1] dmaengine: imx-sdma: remove __init annotation on
> sdma_event_remap
> 
> On Wednesday 11 November 2015 17:20:49 Jason Liu wrote:
> > The sdma_probe function will call sdma_event_remap, but
> > sdma_event_remap marked with the __init annotation which make the
> > kbuild complains as the following log:
> >
> > WARNING: drivers/dma/built-in.o(.text+0x56fc): Section mismatch in
> > reference from the function sdma_probe() to the function
> > .init.text:sdma_event_remap() The function sdma_probe() references the
> > function __init sdma_event_remap().
> > This is often because sdma_probe lacks a __init annotation or the
> > annotation of sdma_event_remap is wrong.
> >
> > Remove the __init annotation on sdma_event_remap to kill this build
> > warning
> >
> > Signed-off-by: Jason Liu <r64343@freescale.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> >
> 
> Looks good. I wonder why I have not caught this with the randconfig
> builds yet.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> One hint for the future: in the patch description, write less about the
> kbuild warning and more about the actual impact of the bug (calling a
> discarded function if the device gets unbound and rebound later, or if we
> get deferred probing).

Yes, that is true indeed. Thanks Arnd.

> 
> 	Arnd
