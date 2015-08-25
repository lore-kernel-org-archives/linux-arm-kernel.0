From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 25 Aug 2015 18:08:40 +0100
Subject: [PATCH 1/7] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <20150819150605.GA13546@localhost>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-2-git-send-email-peter.griffin@linaro.org>
 <20150819150605.GA13546@localhost>
Message-ID: <20150825170840.GA1498@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for reviewing.

On Wed, 19 Aug 2015, Vinod Koul wrote:

> On Wed, Jul 08, 2015 at 05:11:22PM +0100, Peter Griffin wrote:
> > This patch adds the DT binding documentation for the FDMA constroller
> > found on STi based chipsets from STMicroelectronics.
> > 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/st_fdma.txt | 76 +++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/st_fdma.txt b/Documentation/devicetree/bindings/dma/st_fdma.txt
> > new file mode 100644
> > index 0000000..1ec7470
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/st_fdma.txt
> > @@ -0,0 +1,76 @@
> > +* STMicroelectronics Flexible Direct Memory Access Device Tree bindings
> > +
> > +The FDMA is a general-purpose direct memory access controller capable of
> > +supporting 16 independent DMA channels. It accepts up to 32 DMA requests.
> > +The FDMA is based on a Slim processor which require a firmware.
> > +
> > +* FDMA Controller
> > +
> > +Required properties:
> > +- compatible	: Should be "st,fdma_mpe31"
> > +- reg		: Should contain DMA registers location and length
> > +- interrupts	: Should contain one interrupt shared by all channel
> 
> s/channel/channels

Will fix in v2.

> 
> > +- dma-channels	: Number of channels supported by the controller
> > +- #dma-cells	: Must be <3>.
> 
> any reason three?

Yes, it is documented further down in the file under DMA Client.

To make it clearer in V2 I could change to

"- #dma-cells	: Must be <3>. See DMA client section below"?

regards,

Peter.
