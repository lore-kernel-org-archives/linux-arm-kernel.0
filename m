From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Feb 2013 09:45:08 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <201302052226.30754.arnd@arndb.de>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <20130204154153.GA18237@arwen.pp.htv.fi>
 <20130205182848.GJ25185@atomide.com>
 <201302052226.30754.arnd@arndb.de>
Message-ID: <20130206074508.GB22064@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 10:26:30PM +0000, Arnd Bergmann wrote:
> On Tuesday 05 February 2013, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [130204 07:46]:
> > > 
> > > Current DMA abstraction is quite poor, for example there's no way to
> > > compile support for multiple DMA engines. Code also makes certain, IMO
> > > unnecessary, assumptions about the underlying DMA engine (abstraction is
> > > poor, as said above but it we could follow MUSB's programming guide when
> > > it comes to programming DMA transfers).
> > > 
> > > Considering all of the above, it's far better to use DMA engine and get
> > > rid of all the mess.
> > 
> > How about just disable MUSB DMA support if ARCH_MULTIPLATFORM for now?
> > That way MUSB can be fixed up first to support ARCH_MULTIPLATFORM
> > using PIO while sorting out the DMA related issues.
> 
> Sounds ok to me. Someone still needs to do the work to make the non-DMA
> variants of MUSB coexist in one kernel, but as we discussed erlier, that
> should be much simpler.

Yeah, I'm cooking some patches to at least make it buildable. Dropping
unnecessary dependencies and marking da8xx and davinci as depending on
BROKEN seems to be the easiest way; those two glues hasn't seen a real
patch since 2010 or so.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/c82248bc/attachment.sig>
