From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Dec 2014 13:55:50 -0500
Subject: [PATCH 08/27] ARM: mvebu: armada-370-xp: Relicense the device
 tree under GPLv2+/X11
In-Reply-To: <54907A82.6030906@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <1418657915-22775-9-git-send-email-gregory.clement@free-electrons.com>
 <20141215232221.GD19261@kw.sim.vm.gnt>
 <20141216130331.GJ967@titan.lakedaemon.net>
 <20141216133719.GE19261@kw.sim.vm.gnt>
 <20141216144533.GL967@titan.lakedaemon.net>
 <54907A82.6030906@free-electrons.com>
Message-ID: <20141216185550.GQ967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 07:31:30PM +0100, Gregory CLEMENT wrote:
> On 16/12/2014 15:45, Jason Cooper wrote:
> > On Tue, Dec 16, 2014 at 02:37:19PM +0100, Simon Guinot wrote:
> >> On Tue, Dec 16, 2014 at 08:03:31AM -0500, Jason Cooper wrote:
> >>> Simon,
> >>>
> >>> On Tue, Dec 16, 2014 at 12:22:21AM +0100, Simon Guinot wrote:
> >>>> On Mon, Dec 15, 2014 at 04:38:16PM +0100, Gregory CLEMENT wrote:
> >>>>> The current GPL only licensing on the device tree makes it very
> >>>>> impractical for other software components licensed under another
> >>>>> license.
> >>>>>
> >>>>> In order to make it easier for them to reuse our device trees,
> >>>>> relicense our device trees under a GPL/X11 dual-license.
> >>>>>
> >>>>> Cc: Andrew Lunn <andrew@lunn.ch>
> >>>>> Cc: Arnaud Ebalard <arno@natisbad.org>
> >>>>> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >>>>> Cc: Greg Ungerer <gerg@uclinux.org>
> >>>>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >>>>> Cc: Jason Cooper <jason@lakedaemon.net>
> >>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >>>>> Cc: Simon Baatz <gmbnomis@gmail.com>
> >>>>> Cc: Simon Guinot <simon.guinot@sequanux.org>
> >>>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >>>>> Cc: Willy Tarreau <w@1wt.eu>
> >>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >>>>> ---
> >>>>>  arch/arm/boot/dts/armada-370-xp.dtsi | 40 +++++++++++++++++++++++++++++++++---
> >>>>>  1 file changed, 37 insertions(+), 3 deletions(-)
> >>>>
> >>>> Hi Gregory,
> >>>>
> >>>> NAK for me.
> >>>
> >>> Well, I'm a bit surprised that this is the first one. :)  Care to
> >>> explain why so that we can work towards an amenable compromise?
> >>
> >> Hi Jason,
> >>
> >> I am also a bit surprised to be the only one :)
> >>
> >> As I have no interest in a flame war either, I am not gonna elaborate
> >> on this. But in a few words, I don't think that allowing a permissive
> >> licence alternative is good for software sharing (which is important
> >> to me). 
> > 
> > Ok, fair enough.  I just needed to know if the NAK was against the
> > GPLv2+ part or the X11 part.  Clearly, it's the X11 part.
> > 
> > So let's look at what we have (trying to stick to facts):
> > 
> > - alienating contributors in bad (yes, this is first)
> > - sometimes the community has to do something a minority disagrees with,
> >   but it should be avoided, if at all possible.
> > - devicetree is so useful, other projects are adopting it
> > - if our binding docs are good, rewriting dts{i} isn't hard.
> > - rewriting dts{i} can lead to fragmentation
> > - maintaining two devicetree trees would be a pia (X11, GPLonly)
> > - reverting/rewriting GPLonly commits is possible, but see first bullet.
> > - Simon may not be the only contributor who disagrees with X11.
> > - of the known consumers of dts{i}, *BSD is the only one with licensing
> >   issues.
> > 
> > So our goal is to avoid fragmentation by allowing *BSD to use our dts{i}
> > files as is.  Our secondary goal is to avoid a maintenance headache.
> > 
> > Options:
> > 
> > - Ask Simon to find an OSI-compatible license to replace X11 that:
> >    - *BSD can use
> >    - meets the intent of himself and other like-minded authors
> > - Leave licensing as is, but make a statement that *using* the dts
> >   doesn't create a derivative work under the GPL (similar to Linus'
> >   statement re the Linux kernel, Wolfgang and U-Boot, etc).
> > - Screw it, plow forward, and revert/rewrite GPLonly commits
> > - Ignore the whole issue and hope it goes away.
> > 
> 
> Thanks for sum-up the situation and to offer the different choice we have.
> 
> > Personally, I'm in favor of the second one, and think it has the highest
> > chance of success.  After all, ARM-based *BSD is launched from a GPL
> > bootloader in most cases, right (U-Boot, barebox)?  Thoughts?
> 
> Presently I would like to have the answer about the relicesing from all the
> author in CC. Then depending the result we will see where we should go.

Agreed.  We should keep in mind that once we have heard from everybody
(big if), that is still only representative of armada and maybe mvebu
ecosystem. :(  I'm starting to lean even more towards #2...

thx,

Jason.
