From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 May 2010 07:40:40 -0700
Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig
In-Reply-To: <1272957963.1978.25.camel@tubuntu.research.nokia.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203411.25812.30019.stgit@baageli.muru.com>
	<20100430205003.GG29604@atomide.com>
	<20100504005222.GD29604@atomide.com>
	<1272957963.1978.25.camel@tubuntu.research.nokia.com>
Message-ID: <20100504144040.GH29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100504 00:21]:
> Hi,
> 
> On Tue, 2010-05-04 at 02:52 +0200, ext Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [100430 13:47]:
> > > * Tony Lindgren <tony@atomide.com> [100430 13:32]:
> > > > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > > > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > > > omap FB code is fixed.
> > > 
> > > This one I'll drop as soon as the problem is sorted out with
> > > CONFIG_FB_OMAP.
> > 
> > This one seems to be something under drivers/video/omap, so
> > I'll change CONFIG_FB_OMAP to be a module now. Updated patch
> > below.
> > 
> > I'll update omap for-next accordingly, then Tomi can figure
> > it out :)
> 
> This sounds... interesting... =) Any more info on what happens? Does it
> also affect new omapfb driver?

Yeah this is interesting, it seems like the kernel cmdline gets
somehow corrupted for zoom3 with the omap3_defconfig if CONFIG_FB_OMAP=y.
Some options seem to be there, but for example rootwait option is
ignored and the root on MMC never mounts. This is in the current
omap for-next branch.

Hmm, what do you mean with "new omapfb" driver, the stuff you have
queued up?

Regards,

Tony
