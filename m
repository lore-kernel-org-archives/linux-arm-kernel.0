From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 22:26:30 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130205182848.GJ25185@atomide.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <20130204154153.GA18237@arwen.pp.htv.fi> <20130205182848.GJ25185@atomide.com>
Message-ID: <201302052226.30754.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130204 07:46]:
> > 
> > Current DMA abstraction is quite poor, for example there's no way to
> > compile support for multiple DMA engines. Code also makes certain, IMO
> > unnecessary, assumptions about the underlying DMA engine (abstraction is
> > poor, as said above but it we could follow MUSB's programming guide when
> > it comes to programming DMA transfers).
> > 
> > Considering all of the above, it's far better to use DMA engine and get
> > rid of all the mess.
> 
> How about just disable MUSB DMA support if ARCH_MULTIPLATFORM for now?
> That way MUSB can be fixed up first to support ARCH_MULTIPLATFORM
> using PIO while sorting out the DMA related issues.

Sounds ok to me. Someone still needs to do the work to make the non-DMA
variants of MUSB coexist in one kernel, but as we discussed erlier, that
should be much simpler.

	Arnd
