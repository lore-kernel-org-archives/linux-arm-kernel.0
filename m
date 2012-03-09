From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Mar 2012 12:26:53 +0000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <1331295269.1927.54.camel@deskari>
References: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
 <201203091150.11294.arnd@arndb.de> <1331295269.1927.54.camel@deskari>
Message-ID: <201203091226.53749.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 March 2012, Tomi Valkeinen wrote:
>   On Fri, 2012-03-09 at 11:50 +0000, Arnd Bergmann wrote:
> > On Friday 09 March 2012, Tomi Valkeinen wrote:
> > > On Thu, 2012-03-08 at 16:16 +0000, Arnd Bergmann wrote:
> > > > On Thursday 08 March 2012, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > Today's linux-next merge of the arm-soc tree got a conflict in
> > > > > arch/arm/mach-omap1/board-palmtt.c between commit ddba6c7f7ec6 ("OMAP1:
> > > > > pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
> > > > > and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
> > > > > iomap.h") from the arm-soc tree.
> > > > > 
> > > > > I fixed it up (see below) and can carry the fix as necessary.
> > > > 
> > > > Hi Stephen,
> > > > 
> > > > Thanks for fixing up all the conflicts between arm-soc and omap_dss2.
> > > > I think we should make sure they are resolved in one of the trees before
> > > > the merge window.
> > > 
> > > Do we need to? The conflicts seemed to be trivial ones, like arm-soc
> > > adds/removes something that just happens to be next to something else
> > > that I add/remove.
> > > 
> > > My understanding is that it's better to leave those conflicts than to do
> > > "trickery" to avoid them.
> > 
> > Each of the conflicts is simple enough, but I feel it's worth resolving
> > them in this case because there are a number of them. Looking at them
> > again now, it's probably ok either way -- resolving them now or letting
> > Linus take care of them.
> 
> Florian, do you have an opinion about this?
> 
> Merging omapdss tree through arm-soc would make sense for avoiding
> conflicts, because almost every merge window there are some conflicts as
> I often need to edit arch/arm files also. But I'm not sure if we have
> ever had a conflict in drivers/video.
> 
> But still, it's a video driver, and fbdev tree sounds more suited for a
> video driver.
> 
> So I don't know =). Basically it's ok for me either way also. But it
> would be nice to have a standard way of doing this, instead of, for
> example, merging omapdss sometimes through fbdev, sometimes through
> arm-soc, depending on the conflicts...

Actually, I did not suggest omapdss through arm-soc, the idea was that
that the same branch gets merged into both the fbdev and the arm-soc
trees and let the fbdev tree go to Linus first.

	Arnd
