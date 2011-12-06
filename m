From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 00:36:59 +0000
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <20111205235609.GI14542@n2100.arm.linux.org.uk>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
 <20111202202125.GZ31337@atomide.com>
 <alpine.LFD.2.02.1112021637200.2357@xanadu.home>
 <20111205235609.GI14542@n2100.arm.linux.org.uk>
Message-ID: <20111206003659.GJ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 11:56:09PM +0000, Russell King - ARM Linux wrote:
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

Okay, yet again I find myself having to wait hours for a reply - which
I expect will be forthcoming sometime tomorrow afternoon my time.  If
I wait, it means a delay of another 24 hours before I push my tree out.

This is not acceptable.

So I'm pushing my tree out as-is - which means the stuff I pulled
previously is now frozen.  Please submit a patch to fix whatever error
Tony is seeing.
