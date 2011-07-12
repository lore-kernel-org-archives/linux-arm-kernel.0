From: vkoul@infradead.org (Vinod Koul)
Date: Tue, 12 Jul 2011 21:30:18 +0530
Subject: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design plan
In-Reply-To: <20110708100410.GA4957@n2100.arm.linux.org.uk>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
	<20110708100410.GA4957@n2100.arm.linux.org.uk>
Message-ID: <1310486418.14637.1.camel@psiaudioba-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-08 at 11:04 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 08, 2011 at 01:52:17PM +0530, Raju, Sundaram wrote:
> > I am planning to move TI SDMA driver in OMAP tree
> > into the dmaengine framework.
> > 
> > The first immediate issue of concern I noticed is the
> > huge number of client drivers that use the existing SDMA driver.
> > More than 15 client drivers are using the current SDMA driver.
> > 
> > Moving the SDMA driver along with all of these client drivers at a
> > single stretch seems a humungous task. 
> > I noticed a model in the existing DMA drivers in dmaengine
> > framework that will over come this issue. 
> 
> It _is_ sane to build a dmaengine driver on top of the existing SoC
> private API, then convert the drivers to DMA engine, and then cleanup
> the resulting DMA engine driver.
> 
> What we must make sure though is that the DMA engine slave API (which
> isn't well documented) is correctly implemented before drivers are
> converted over to use the DMA engine support code, otherwise we may
> end up with lots of drivers that require re-fixing several times over.
Russel,

Remember we have addressed the documentation part, is there something
else you feel is still missing?

-- 
~Vinod Koul
Intel Corp.
