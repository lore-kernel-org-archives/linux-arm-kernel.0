From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Jun 2015 22:53:51 +0200
Subject: [PATCH v2 3/5] dmaengine: mv_xor: add support for a38x command
 in descriptor mode
In-Reply-To: <20150608103447.GE28601@localhost>
References: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432645656-20504-4-git-send-email-maxime.ripard@free-electrons.com>
 <20150608103447.GE28601@localhost>
Message-ID: <20150608205351.GC23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, Jun 08, 2015 at 04:04:47PM +0530, Vinod Koul wrote:
> On Tue, May 26, 2015 at 03:07:34PM +0200, Maxime Ripard wrote:
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > The Marvell Armada 38x SoC introduce new features to the XOR engine,
> > especially the fact that the engine mode (MEMCPY/XOR/PQ/etc) can be part of
> > the descriptor and not set through the controller registers.
> > 
> > This new feature allows mixing of different commands (even PQ) on the same
> > channel/chain without the need to stop the engine to reconfigure the engine
> > mode.
> > 
> > Refactor the driver to be able to use that new feature on the Armada 38x,
> > while keeping the old behaviour on the older SoCs.
> > 
> > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/dma/mv-xor.txt |  2 +-
> >  drivers/dma/mv_xor.c                             | 82 ++++++++++++++++++++----
> >  drivers/dma/mv_xor.h                             |  7 ++
> >  3 files changed, 76 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
> > index 7c6cb7fcecd2..cc29c35266e2 100644
> > --- a/Documentation/devicetree/bindings/dma/mv-xor.txt
> > +++ b/Documentation/devicetree/bindings/dma/mv-xor.txt
> > @@ -1,7 +1,7 @@
> >  * Marvell XOR engines
> >  
> >  Required properties:
> > -- compatible: Should be "marvell,orion-xor"
> > +- compatible: Should be "marvell,orion-xor" or "marvell,armada-380-xor"
>
> marvell,armada-380-xor doesnt seem to exist in binding ?

I'm not sure what you mean, this patch precisely adds that compatible
to the bindings documentation.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/acaef5d5/attachment.sig>
