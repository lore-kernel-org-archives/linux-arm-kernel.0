From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 17 Sep 2013 15:25:39 -0300
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130917181742.GA4182@obsidianresearch.com>
References: <20130916224743.GA18349@obsidianresearch.com>
 <20130917133206.GB2488@localhost>
 <20130917153619.GA14098@obsidianresearch.com>
 <20130917200301.66e8ccb9@skate>
 <20130917181742.GA4182@obsidianresearch.com>
Message-ID: <20130917182538.GC4231@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 12:17:42PM -0600, Jason Gunthorpe wrote:
> On Tue, Sep 17, 2013 at 08:03:01PM +0200, Thomas Petazzoni wrote:
> > Dear Jason Gunthorpe,
> > 
> > On Tue, 17 Sep 2013 09:36:19 -0600, Jason Gunthorpe wrote:
> > 
> > > Since they are all the same I'll respin the patch and add the ranges
> > > to the kirkwood.dtsi and remove it from all the board files, (which is
> > > where I started, but then saw that board files had a ranges
> > > already)
> > 
> > In Armada 370/XP land, we've decided to always put the ranges in the
> > per-board .dts file. The reason is that sometimes, a board needs to
> > add
> 
> Yes, I recall you talking about this, that is why initially just went
> adding to the existing mbus ranges in the board files.
> 
> However, is that really still the case? Now that PEX uses a difference
> scheme it seems they all washed out to be the same.
> 
> All the armada-370 boards in mainline seem to be the same today.
> 
> armada-xp looks the same as well, except that armada-xp-axpwifiap.dts
> is missing MBUS_ID(0x01, 0x2f), but it looks like it would be harmless
> to add, even though it is not used.
> 
> > A better solution would be to have a += operator in the DT language,
> 
> Agree
> 
> > but until that exists, we thought that pushing the ranges property down
> > to the .dts file was the least horrible solution.
> 
> I think we can get away with doing it the other way for kirkwood,
> here are my reasons:
>  - Kirkwood is mature now, the DT is basically complete, we shouldn't
>    need to churn the ranges in the dtsi much, if at all.
>  - There are 31 kirkwood dts files, and none of them need a ranges
>    different from the default
>  - Kirkwood has more than enough mbus windows, we don't need to be
>    stingy with them
>  - The board files were already sort of like this, but a big chunk
>    of the 31 boards were missing ranges entirely.
> 
> Basically, no board file has a ranges, only the kirkwood.dtsi has a
> ranges.
> 

While I'm not advocating any of the alternatives, I think we could
add a comment *now* to all our device trees explaining how the ranges
property is *not* inheritable and that a child/board "dts" ranges
property will override the parent's completely.

Note that I'm not volunteering :)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
