From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 09 Mar 2012 14:14:29 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 omap_dss2 tree
In-Reply-To: <201203091150.11294.arnd@arndb.de>
References: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
 <201203081616.12510.arnd@arndb.de> <1331285751.1927.20.camel@deskari>
 <201203091150.11294.arnd@arndb.de>
Message-ID: <1331295269.1927.54.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-03-09 at 11:50 +0000, Arnd Bergmann wrote:
> On Friday 09 March 2012, Tomi Valkeinen wrote:
> > On Thu, 2012-03-08 at 16:16 +0000, Arnd Bergmann wrote:
> > > On Thursday 08 March 2012, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Today's linux-next merge of the arm-soc tree got a conflict in
> > > > arch/arm/mach-omap1/board-palmtt.c between commit ddba6c7f7ec6 ("OMAP1:
> > > > pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
> > > > and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
> > > > iomap.h") from the arm-soc tree.
> > > > 
> > > > I fixed it up (see below) and can carry the fix as necessary.
> > > 
> > > Hi Stephen,
> > > 
> > > Thanks for fixing up all the conflicts between arm-soc and omap_dss2.
> > > I think we should make sure they are resolved in one of the trees before
> > > the merge window.
> > 
> > Do we need to? The conflicts seemed to be trivial ones, like arm-soc
> > adds/removes something that just happens to be next to something else
> > that I add/remove.
> > 
> > My understanding is that it's better to leave those conflicts than to do
> > "trickery" to avoid them.
> 
> Each of the conflicts is simple enough, but I feel it's worth resolving
> them in this case because there are a number of them. Looking at them
> again now, it's probably ok either way -- resolving them now or letting
> Linus take care of them.

Florian, do you have an opinion about this?

Merging omapdss tree through arm-soc would make sense for avoiding
conflicts, because almost every merge window there are some conflicts as
I often need to edit arch/arm files also. But I'm not sure if we have
ever had a conflict in drivers/video.

But still, it's a video driver, and fbdev tree sounds more suited for a
video driver.

So I don't know =). Basically it's ok for me either way also. But it
would be nice to have a standard way of doing this, instead of, for
example, merging omapdss sometimes through fbdev, sometimes through
arm-soc, depending on the conflicts...

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/8ce8e297/attachment-0001.sig>
