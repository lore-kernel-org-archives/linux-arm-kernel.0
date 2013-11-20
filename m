From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 18:03:58 +0100
Subject: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
In-Reply-To: <528CE71D.5090300@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <201311201637.36733.arnd@arndb.de> <528CE71D.5090300@wwwdotorg.org>
Message-ID: <201311201803.58393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013, Stephen Warren wrote:
> > +- #iommu-cells : Must be <1>. This dictates the length of DMA specifiers in
> > +  client nodes' dmas properties. The specifier represents the DMA request
> > +  select value for the peripheral. For more details, consult the Tegra TRM's
> > +  documentation of the APB DMA channel control register REQ_SEL field.
> >  
> >  Examples:
> >  
> > @@ -36,4 +40,5 @@ apbdma: dma at 6000a000 {
> >       clocks = <&tegra_car 34>;
> >       resets = <&tegra_car 34>;
> >       reset-names = "dma";
> > +     #iommu-cells = <1>;


s/iommu/dma/

Otherwise looks good. The dts files are correct, so I guess it's just
a typo here.

	Arnd
