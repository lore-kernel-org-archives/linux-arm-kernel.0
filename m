From: Stefan.Bruens@rwth-aachen.de (=?iso-8859-1?Q?Br=FCns=2C_Stefan?=)
Date: Mon, 4 Sep 2017 14:30:59 +0000
Subject: [PATCH 05/10] dmaengine: sun6i: Move number of
 pchans/vchans/request to device struct
In-Reply-To: <20170904074355.niloziky42aki7bg@flea>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-6-stefan.bruens@rwth-aachen.de>
 <20170904074355.niloziky42aki7bg@flea>
Message-ID: <3533197.81BdoSVRz8@sbruens-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 4. September 2017 09:43:55 CEST Maxime Ripard wrote:
> On Mon, Sep 04, 2017 at 12:40:56AM +0200, Stefan Br?ns wrote:
> > Preparatory patch: If the same compatible is used for different SoCs which
> > have a common register layout, but different number of channels, the
> > channel count can no longer be stored in the config. Store it in the
> > device structure instead.
> > 
> > Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> 
> As stated already, we already are going to have a different
> compatible, and this is not something that will change from one
> instance to the other. Having code is therefore:
>   A) Making the code more complex
>   B) For no particular reason.

If the dma channel count (which is a standard dma binding, likely for a 
reason) goes into the devicetree, it has to be moved out of the config.

The R40 (which has register manuals available) has the same register layout as 
the A64, but *does* have a different channel count. So you think it is a good 
idea to introduce a new compatible again?

If you had been half as picky when merging the H3 and A83T support, we would 
not have this mess now.

There is also the H6, where there is no register manual available yet, but I  
bet it has the H3 (and A64, H5, R40) register layout, but unlikely the same 
number of DMA channels *and* the same number of ports.

Regards,

Stefan
