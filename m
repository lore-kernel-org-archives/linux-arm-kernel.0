From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2011 19:18:53 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110828083934.GA4254@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<5595208.OB5dBohxQP@wuerfel>
	<20110828083934.GA4254@yookeroo.fritz.box>
Message-ID: <201108291918.53745.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 August 2011, David Gibson wrote:
> > Right, and I guess we can simply ignore DMA and ioport resources because they
> > are extremely rare, right?
> 
> Well, remember it's where resources can appear in the DT node that
> matters, not what the types are in the platform device.  ioports will
> typically appear suitably encoded in 'reg', so that's covered.  I've
> never been very clear on what exactly DMA resources cover, but yeah,
> you might need something for dma-reg or other device tree properties.

DMA resources are only meaningful with the legacy ISA dma API, all
other uses are basically ad-hoc and I think we can ignore them or
replace them with proper bindings when converting the drivers to
device-tree based probing.

	Arnd
