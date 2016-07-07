From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 12:08:01 +0200
Subject: [GIT PULL] STi DT updates for v4.8
In-Reply-To: <577E0734.2070206@st.com>
References: <5776701A.1000808@st.com> <20160707052827.GL32389@localhost>
 <577E0734.2070206@st.com>
Message-ID: <9427724.UUV0z7XpPd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 9:39:32 AM CEST Patrice Chotard wrote:
> On 07/07/2016 07:28 AM, Olof Johansson wrote:
> > On Fri, Jul 01, 2016 at 03:28:58PM +0200, Patrice Chotard wrote:
> >> ----------------------------------------------------------------
> >> Highlights:
> >> -----------
> >>   -add STi critical clocks
> >> - as discussed on IRC with Lee Jones, remove SPI hack wich has dependecy
> >> with critical clocks
> >>
> >> ----------------------------------------------------------------
> >> Lee Jones (3):
> >>        ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
> >>        ARM: sti: stih410-clocks: Identify critical clocks
> >>        spi: st-ssc4: Remove 'no clocking' hack
> > THere are more patches than this in this branch -- there are three clock
> > branches that by the look of it have been applied by Stephen Boyd.
> >
> > However, since they have been brought in without doing a merge, it's hard for
> > us to tell where they came form, and/or if they're in a shared branch
> > somewhere. Therefore, I recommend doing a --no-ff merge of the branch, so it's
> > obvious from the merge commit where they came form. They also need to be part
> > of the diffstat.
> >
> > Finally, the clk patch doesn't really belong in the DT branch here. It's
> > probably a suitable patch to send to the clk maintainers after the DT changes
> > have gone in, i.e. for 4.9.
> >
> > Please respin this pull request and we'll take another look!
> 
> There was a discussion on IRC armlinux's channel between Lee Jones, Arnd 
> Bergman
> and Mark Brown about the way to proceed with this pull request.
> 
> As there are dependencies between the 3 critical clocks patches on 
> Stephen Boyd's
> branch clk-next/clk-st-critical, our STi DT and our SPI drivers which 
> remove a temporary
> clock hack, the decision was taken to put our DT STi fixes on top of 
> Stephen Boyd critical clk
>   branch and our SPI patches on the top.
> 
> For more details i put in attachment the IRC exchange about this.

This information belongs into the tag description, it's required for
us to make the decision whether the branch is can be merged or not.

In particular, you need to spell out the specific dependency that
exists between the clk patches and the dt patches.

What I understood from Lee before is that there is no such dependency
at all and the only thing that needs the clk changes is the spi
patch, while the DT patches and the clk patches are independent.

However, Lee's explanation was a bit ambiguous and could be interpreted
as meaning that there is another dependency here, which was simply
not explained.

	Arnd
