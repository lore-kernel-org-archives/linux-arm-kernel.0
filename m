From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 21:06:45 +0100
Subject: [PATCH 08/27] ARM: mvebu: armada-370-xp: Relicense the device
 tree under GPLv2+/X11
In-Reply-To: <20141216185550.GQ967@titan.lakedaemon.net>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <54907A82.6030906@free-electrons.com>
 <20141216185550.GQ967@titan.lakedaemon.net>
Message-ID: <2343908.plBCRoX2ek@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 13:55:50 Jason Cooper wrote:
> On Tue, Dec 16, 2014 at 07:31:30PM +0100, Gregory CLEMENT wrote:
> > On 16/12/2014 15:45, Jason Cooper wrote:
> > > On Tue, Dec 16, 2014 at 02:37:19PM +0100, Simon Guinot wrote:
> > >> On Tue, Dec 16, 2014 at 08:03:31AM -0500, Jason Cooper wrote:
> > >>> On Tue, Dec 16, 2014 at 12:22:21AM +0100, Simon Guinot wrote:
> > >>>> Hi Gregory,
> > >>>>
> > >>>> NAK for me.
> > >>>
> > >>> Well, I'm a bit surprised that this is the first one.   Care to
> > >>> explain why so that we can work towards an amenable compromise?
> > >>
> > >> Hi Jason,
> > >>
> > >> I am also a bit surprised to be the only one 
> > >>
> > >> As I have no interest in a flame war either, I am not gonna elaborate
> > >> on this. But in a few words, I don't think that allowing a permissive
> > >> licence alternative is good for software sharing (which is important
> > >> to me). 
> > > 
> > > Ok, fair enough.  I just needed to know if the NAK was against the
> > > GPLv2+ part or the X11 part.  Clearly, it's the X11 part.
> > > 
> > > So let's look at what we have (trying to stick to facts):
> > > 
> > > - alienating contributors in bad (yes, this is first)
> > > - sometimes the community has to do something a minority disagrees with,
> > >   but it should be avoided, if at all possible.
> > > - devicetree is so useful, other projects are adopting it
> > > - if our binding docs are good, rewriting dts{i} isn't hard.
> > > - rewriting dts{i} can lead to fragmentation
> > > - maintaining two devicetree trees would be a pia (X11, GPLonly)
> > > - reverting/rewriting GPLonly commits is possible, but see first bullet.
> > > - Simon may not be the only contributor who disagrees with X11.
> > > - of the known consumers of dts{i}, *BSD is the only one with licensing
> > >   issues.
> > > 
> > > So our goal is to avoid fragmentation by allowing *BSD to use our dts{i}
> > > files as is.  Our secondary goal is to avoid a maintenance headache.
> > > 
> > > Options:
> > > 
> > > - Ask Simon to find an OSI-compatible license to replace X11 that:
> > >    - *BSD can use
> > >    - meets the intent of himself and other like-minded authors
> > > - Leave licensing as is, but make a statement that *using* the dts
> > >   doesn't create a derivative work under the GPL (similar to Linus'
> > >   statement re the Linux kernel, Wolfgang and U-Boot, etc).
> > > - Screw it, plow forward, and revert/rewrite GPLonly commits
> > > - Ignore the whole issue and hope it goes away.
> > > 
> > 
> > Thanks for sum-up the situation and to offer the different choice we have.
> > 
> > > Personally, I'm in favor of the second one, and think it has the highest
> > > chance of success.  After all, ARM-based *BSD is launched from a GPL
> > > bootloader in most cases, right (U-Boot, barebox)?  Thoughts?
> > 
> > Presently I would like to have the answer about the relicesing from all the
> > author in CC. Then depending the result we will see where we should go.
> 
> Agreed.  We should keep in mind that once we have heard from everybody
> (big if), that is still only representative of armada and maybe mvebu
> ecosystem.   I'm starting to lean even more towards #2...

Looking at the commits that Simon did, it covers all the Lacie .dts files,
and one single-line change to armada-370-xp.dtsi.

I think it's definitely best to respect Simon's view on the Lacie files
and not try to undo or rewrite those. With the one-line change, there
are other options:

- Ask Simon to agree to a license change for that file
- Argue that a one-line change cannot be covered under copyright and
  change the license anyway.
- Change that line again and modify the driver accordingly

	Arnd
