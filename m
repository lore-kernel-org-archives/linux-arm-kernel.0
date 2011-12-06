From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Dec 2011 19:33:34 -0500 (EST)
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <20111205235609.GI14542@n2100.arm.linux.org.uk>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
 <20111202202125.GZ31337@atomide.com>
 <alpine.LFD.2.02.1112021637200.2357@xanadu.home>
 <20111205235609.GI14542@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112051927250.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2011, Russell King - ARM Linux wrote:

> On Fri, Dec 02, 2011 at 04:39:31PM -0500, Nicolas Pitre wrote:
> > On Fri, 2 Dec 2011, Tony Lindgren wrote:
> > 
> > > Hi Nico,
> > > 
> > > * Nicolas Pitre <nico@fluxnic.net> [111115 21:21]:
> > > > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > 
> > > > A generic version should replace this later.
> > > > 
> > > > As io.c has become nearly empty, omap_init_consistent_dma_size() is moved
> > > > into common.c so that io.c can be removed entirely.
> > > 
> > > Sorry for the delay on trying this series out. It boots fine
> > > on omap2/3/4 as Kevin already noted. However, the following
> > > fix is needed for this patch to keep things building for
> > > omap1_defconfig.
> > >  
> > > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > 
> > > With the following fix it works on what I tested. That's
> > > osk5912 n800 2430sdp n900 zoom3 and blaze. If you're still
> > > taking acks for this series:
> > > 
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > OK, thanks for testing.  Since Russell didn't commit this to his stable 
> > branch yet I simply folded in your fix and added your tested-by tag.
> 
> So I'm about to push what I had out in the devel-stable branch... what
> am I supposed to do with this?

Please repull to get the OMAP1 fix:

	git://git.linaro.org/people/nico/linux vmalloc

Most reports are now positive, except one: ux500.

I think at this point, it could be a good thing to merge this into your 
stable branch nevertheless, given that the changes are quite extensive 
and people might want to build on top of this.  The ux500 will be fixed 
with an additional patch soon once this is debugged.  If not then please 
keep merging it for linux-next.


Nicolas
