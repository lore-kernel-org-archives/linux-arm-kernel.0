From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Jun 2018 01:32:20 -0700
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.18
In-Reply-To: <20180528074436.rctyzocv4qfmdfzy@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
 <20180526211420.jmme6ikrgdiw76u7@localhost>
 <20180528074436.rctyzocv4qfmdfzy@verge.net.au>
Message-ID: <20180602083220.o6b7xqziugeqyd46@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 09:44:41AM +0200, Simon Horman wrote:
> Hi Olof,
> 
> On Sat, May 26, 2018 at 02:14:20PM -0700, Olof Johansson wrote:
> > Hi Simon,
> > 
> > On Fri, May 18, 2018 at 01:16:00PM +0200, Simon Horman wrote:
> > > Hi Olof, Hi Kevin, Hi Arnd,
> > > 
> > > Please consider these Renesas ARM64 based SoC DT updates for v4.18.
> > > 
> > > 
> > > The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> > > 
> > >   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.18
> > > 
> > > for you to fetch changes up to 908001d778eba06ee1d832863d4e9a1e2cfd4746:
> > > 
> > >   arm64: dts: renesas: salvator-common: Add ADV7482 support (2018-05-18 11:52:03 +0200)
> > 
> > This pull request is really, really hard for us to digest. The tag
> > description is very large, and it repeats several SoCs several times,
> > making it hard to get an overview of what is in it. The verbosity of "<x>
> > says.." makes it harder on this size of a pull request as well.
> 
> I appologise that this pull-request has turned out to be hard to digest.
> 
> I think that one reason for this is that there are an unusally large number
> of commits. It seems that the team has been a little more productive than
> usual and I might have been better to send a smaller pull-request earlier
> in the development cycle and then follow-up with a second batch. I'll try
> to pay more attention to this aspect of things going forwards.
> 
> Regarding your specific comments:
> 
> * Repetition of SoCs. I do try to group things in a logical manner,
>   but clearly I failed in this case. I'll try to make that a bit clearer
>   in future.

I don't think you're helped by the fact that Renesas product names seem
to have little rhyme or reason to them, and mumbles families and product
names and numbers seemingly random. :(

> * Verbosity: There as a request a few development cycles for me
>   to include more information in the commit logs. It seems that
>   I may have gone a bit too far. I'll try to find a better balance next
>   time around.

There's a balance to be found here. You chose to describe some very small
changes with 3 lines of description, and as a result it's hard to get an
overview of what's in the pull request.

As a maintainer, you should strive to be the editor that makes sure that things
are easy to understand, and arranged in a manner that makes sense for both your
developers and the rest of the community (and the upstream maintainers).

> * Patches for the same change split up for different SoCs/boards.
>   Featurs broken out into incremental patches. And so on.
> 
>   This has been a long-standing practice for Renesas SoC development.
>   We find that in general it aids review. It also works well
>   with the way we develop patches. But I do see your point that
>   it may be a little excessive - f.e. multiple patches for the same
>   whitespace fixes. Again, we'll try to find a better balance.

I can understand where the policy comes from, but it seems to me that at least
in this case it's one that's no longer scaling to the number of SoCs you're
supporting, and the number of (each small) additions that you're doing.
Grouping in some of the simpler dtsi additions into one per SoC, or one per IP
block across all SoCs, seems like something to attempt here.


> > For example:
> > 
> > > * Condor board with R-Car V3H (r8a77980) SoC
> > >   - Enable eMMC
> > > 
> > >     Sergei Shtylyov says "We're adding the R8A77980 MMC (SDHI)
> > >     device nodes and then enable eMMC support on the Condor board."
> > 
> > The "Enable eMMC" line is just fine here.
> > 
> > > ----------------------------------------------------------------
> > > Geert Uytterhoeven (11):
> > >       arm64: dts: renesas: draak: Rename EtherAVB "mdc" pin group to "mdio"
> > >       arm64: dts: renesas: salvator-common: Rename EtherAVB "mdc" pin group to "mdio"
> > >       arm64: dts: renesas: ulcb: Rename EtherAVB "mdc" pin group to "mdio"
> > 
> > Why can't these be done in one commit?
> > 
> > >       arm64: dts: renesas: r8a7795: Correct whitespace
> > >       arm64: dts: renesas: r8a7796: Correct whitespace
> > >       arm64: dts: renesas: r8a77965: Correct whitespace
> > 
> > Do these really need to be three commits to fix some whitespace?
> > 
> > >       arm64: dts: renesas: ulcb: Add BD9571 PMIC
> > >       arm64: dts: renesas: salvator-common: Add PMIC DDR Backup Power config
> > >       arm64: dts: renesas: ulcb: Add PMIC DDR Backup Power config
> > >       arm64: dts: renesas: r8a77970: Add secondary CA53 CPU core
> > >       arm64: dts: renesas: r8a77970: Add Cortex-A53 PMU node
> > 
> > Why can't these be done in the same commit?
> > 
> > > Kieran Bingham (7):
> > >       arm64: dts: renesas: r8a77965: Add FCPF and FCPV instances
> > >       arm64: dts: renesas: r8a77965: Add VSP instances
> > >       arm64: dts: renesas: r8a77965: Populate the DU instance placeholder
> > >       arm64: dts: renesas: r8a77965: Add HDMI encoder instance
> > >       arm64: dts: renesas: r8a77965-salvator-x: Enable DU external clocks and HDMI
> > >       arm64: dts: renesas: r8a77965-salvator-xs: Enable DU external clocks and HDMI
> > 
> > These two can probably be in one commit as well.
> > 
> > >       arm64: dts: renesas: salvator-common: Add ADV7482 support
> > > 
> > > Kuninori Morimoto (8):
> > >       arm64: dts: renesas: r8a7795: add HDMI sound support
> > >       arm64: dts: renesas: r8a7796: add HDMI sound support
> > 
> > ... starting to see a trend?
> > 
> > >       arm64: dts: renesas: salvator-common: use audio-graph-card for Sound
> > >       arm64: dts: renesas: r8a7795-es1-salvator-x: enable HDMI sound
> > >       arm64: dts: renesas: r8a7795-salvator-xs: enable HDMI sound
> > >       arm64: dts: renesas: r8a7796-salvator-xs: enable HDMI sound
> > >       arm64: dts: renesas: r8a7795-salvator-x: enable HDMI sound
> > >       arm64: dts: renesas: r8a7796-salvator-x: enable HDMI sound
> > 
> > ... and more.
> > 
> > > 
> > > Magnus Damm (5):
> > >       arm64: dts: renesas: r8a77970: Update IPMMU DS1 bit number
> > >       arm64: dts: renesas: r8a7795: Enable IPMMU devices
> > >       arm64: dts: renesas: r8a7796: Enable IPMMU devices
> > >       arm64: dts: renesas: r8a77970: Enable IPMMU devices
> > >       arm64: dts: renesas: r8a77995: Enable IPMMU devices
> > 
> > I think these 4 could be in one commit too.
> > 
> > > 
> > > Niklas S?derlund (11):
> > >       arm64: dts: renesas: r8a7795: decrease temperature hysteresis
> > >       arm64: dts: renesas: r8a7796: decrease temperature hysteresis
> > >       arm64: dts: renesas: r8a77965: use r8a77965-sysc binding definitions
> > >       arm64: dts: renesas: r8a77965: Add R-Car Gen3 thermal support
> > >       arm64: dts: renesas: r8a77965: add I2C support
> > >       arm64: dts: renesas: r8a7795: add VIN and CSI-2 nodes
> > >       arm64: dts: renesas: r8a7795-es1: add CSI-2 node
> > >       arm64: dts: renesas: r8a7796: add VIN and CSI-2 nodes
> > >       arm64: dts: renesas: r8a77965: add VIN and CSI-2 nodes
> > >       arm64: dts: renesas: r8a77970: add VIN and CSI-2 nodes
> > 
> > 
> > .... etc, etc. I'll stop here.
> > 
> > 
> > I haven't merged this branch yet, will need to set aside more time to review
> > the contents. I can't guarantee that it'll make v4.18 but I'll try.
> 
> Please let me know if there is anything I can do to help make this happen.
> This work is very important to Renesas.

I've queued this and the SoC branch up in a next/late branch now. I'm planning
on sending it in unless it's a messy or hard merge window for some reason.


-Olof
