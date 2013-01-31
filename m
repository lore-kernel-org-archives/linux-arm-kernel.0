From: mporter@ti.com (Matt Porter)
Date: Thu, 31 Jan 2013 13:32:55 -0500
Subject: [PATCH v6 03/10] ARM: edma: add AM33XX support to the private
 EDMA API
In-Reply-To: <201301300932.58732.arnd@arndb.de>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-4-git-send-email-mporter@ti.com>
 <201301300932.58732.arnd@arndb.de>
Message-ID: <20130131183255.GI2244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:32:58AM +0000, Arnd Bergmann wrote:
> On Wednesday 30 January 2013, Matt Porter wrote:
> > +               dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
> > +               of_dma_controller_register(dev->of_node,
> > +                                          of_dma_simple_xlate,
> > +                                          &edma_filter_info);
> > +       }
> 
> How do you actually deal with the problem mentioned by Padma, that
> the filter function does not know which edma instance it is looking
> at? If you assume that there can only be a single edma instance in
> the system, that is probably a limitation that should be documented
> somewhere, and ideally the probe() function should check for that.

I make an assumption of one edma instance in the system in the case of
DT being populated. This is always true right now as the only SoC with
two EDMA controllers in existence is Davinci DA850. Until recently,
Davinci had no DT support. Given the steady work being done today on DT
support for DA850, it'll probably be something needed in 3.10.

I will add a comment and check in probe() to capture this assumption
and then plan to update separately to support DA850 booting from DT.

-Matt
