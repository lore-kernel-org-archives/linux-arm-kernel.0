From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Apr 2013 22:39:31 +0800
Subject: [PATCH 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <CAOMZO5BkPTZ7guS1cPeZ+s7vXWh1-9Tf7GyJ6ro6tzOHn_Cm_Q@mail.gmail.com>
References: <1366812273-10833-1-git-send-email-shawn.guo@linaro.org>
 <1366812273-10833-3-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5BkPTZ7guS1cPeZ+s7vXWh1-9Tf7GyJ6ro6tzOHn_Cm_Q@mail.gmail.com>
Message-ID: <20130424143930.GC2736@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 11:23:04AM -0300, Fabio Estevam wrote:
> On Wed, Apr 24, 2013 at 11:04 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > +ssi2: ssi at 70014000 {
> > +       compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> > +       reg = <0x70014000 0x4000>;
> > +       interrupts = <30>;
> > +       clocks = <&clks 49>;
> > +       dmas = <&sdma 24 DMA_PRIO_HIGH IMX_DMATYPE_SSI_SP>,
> > +              <&sdma 25 DMA_PRIO_HIGH IMX_DMATYPE_SSI_SP>;
> 
> The document says:
> "third cell specifies the peripheral type and priority of DMA transfer
> respectively"
> 
> ,but what I see in this example is the opposite:
> 
> priority of DMA and then peripheral type.

Ah, yes.  Will fix it.  Thanks.

Shawn
