From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Mar 2013 09:14:04 +0800
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <512F17B0.5080705@freescale.com>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
 <512F17B0.5080705@freescale.com>
Message-ID: <20130301011401.GA30499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 04:39:12PM +0800, Huang Shijie wrote:
> ? 2013?02?27? 23:25, Shawn Guo ??:
> > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> > @@ -7,10 +7,12 @@ Required properties:
> >    - compatible : should be "fsl,<chip>-gpmi-nand"
> >    - reg : should contain registers location and length for gpmi and bch.
> >    - reg-names: Should contain the reg names "gpmi-nand" and "bch"
> > -  - interrupts : The first is the DMA interrupt number for GPMI.
> > -                 The second is the BCH interrupt number.
> > -  - interrupt-names : The interrupt names "gpmi-dma", "bch";
> > -  - fsl,gpmi-dma-channel : Should contain the dma channel it uses.
> > +  - interrupts : BCH interrupt number.
> > +  - interrupt-names : Should be "bch".
> why split out the bch interrupt? It seems no use to do it.
> 
The real change here is to remove gpmi-dma interrupt, since we have all
dma interrupts defined in dma controller node.

Shawn
