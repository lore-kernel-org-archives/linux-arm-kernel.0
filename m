From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Jan 2014 09:54:27 +0900
Subject: [PATCH 0/8] ARM: shmobile: Conditionally select SMSC_PHY
In-Reply-To: <201401091215.33255.arnd@arndb.de>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
 <20140109051311.GH2132@verge.net.au>
 <201401091215.33255.arnd@arndb.de>
Message-ID: <20140110005427.GD22965@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:15:32PM +0100, Arnd Bergmann wrote:
> On Thursday 09 January 2014, Simon Horman wrote:
> > On Tue, Jan 07, 2014 at 05:48:00PM +0900, Simon Horman wrote:
> > > Select the SMSC_PHY if ethernet is enabled on shmbile boards
> > > that have an SMSC phy. This allows the SMSC-specific phy driver
> > > to be used rather than relying on generic phy code.
> > > 
> > > Based on the renesas-devel-v3.13-rc7-20140107 tag
> > > of my renesas tree.
> > 
> > I have queued up these changes.
> > 
> 
> I don't have an objection to the patches themselves, but a general
> feeling that it would be better to have larger combined patches than
> splitting them out per board.
> 
> I'm cautious with this comment because most people seem to do the
> opposite and combine too many things into large patches, but I think
> when you have identical changeset comments and change the same Kconfig
> file in all of them, you can save yourself and the reviewers some work.

Thanks, I think that is a reasonable comment.

I expected to be more variance between the changes. And in particular
I expected more than one PHY driver to be involved. But as I checked
the hardware on each board, wrote a patch and tested it turned
out that SMSC was used by all the boards. So I was left with a stack
of very similar patches.

In hindsight it might have been better to squash them at that point.
But I too am wary of combining too many things into one patch and
ended up leaning too far the other way.

As I have already queued them up I'd rather not squash them at this point.
