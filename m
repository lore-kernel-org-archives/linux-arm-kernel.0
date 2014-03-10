From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Mar 2014 15:40:33 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <1394461668.2270.47.camel@shinybook.infradead.org>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <5345792.VhzckVI5HA@wuerfel>
 <1394461668.2270.47.camel@shinybook.infradead.org>
Message-ID: <4828160.ZrKNlE4ee8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 07:27:48 David Woodhouse wrote:
> 
> > There are multiple reasons why
> > we have to pass the dmaengine device to the dma-mapping API at the moment
> > rather than the slave device, but in essence it comes down to the engine
> > being the one that is the master on its parent bus. A trivial example
> > where it goes wrong would be the slave living on a 32-bit noncoherent bus
> > and the master living on a 64-bit coherent bus.
> 
> That's true in the general case, certainly. But in this case we're
> basically just talking about different functions of a multifunction
> device. 

Ah, I thought you were talking about a generic SoC with lots of units
on it.

> It may turn out that we need the *flexibility* to specify which
> device shall be used for DMA mappings for a given channel, even if in
> *most* cases it ends up being the DMA controller itself.

Yes, that would probably work with a helper function that can
pull the right device structure out of the ACPI description (or
whatever the DMA engine needs) given the dma channel pointer, or
fall back to the dma engine.

	Arnd
