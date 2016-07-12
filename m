From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2016 10:24:48 +0100
Subject: [GIT PULL] STi DT updates for v4.8
In-Reply-To: <9427724.UUV0z7XpPd@wuerfel>
References: <5776701A.1000808@st.com> <20160707052827.GL32389@localhost>
 <577E0734.2070206@st.com> <9427724.UUV0z7XpPd@wuerfel>
Message-ID: <20160712092448.GE1611@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Jul 2016, Arnd Bergmann wrote:

> On Thursday, July 7, 2016 9:39:32 AM CEST Patrice Chotard wrote:
> > On 07/07/2016 07:28 AM, Olof Johansson wrote:
> > > On Fri, Jul 01, 2016 at 03:28:58PM +0200, Patrice Chotard wrote:
> > >> ----------------------------------------------------------------
> > >> Highlights:
> > >> -----------
> > >>   -add STi critical clocks
> > >> - as discussed on IRC with Lee Jones, remove SPI hack wich has dependecy
> > >> with critical clocks
> > >>
> > >> ----------------------------------------------------------------
> > >> Lee Jones (3):
> > >>        ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
> > >>        ARM: sti: stih410-clocks: Identify critical clocks
> > >>        spi: st-ssc4: Remove 'no clocking' hack
> > > THere are more patches than this in this branch -- there are three clock
> > > branches that by the look of it have been applied by Stephen Boyd.
> > >
> > > However, since they have been brought in without doing a merge, it's hard for
> > > us to tell where they came form, and/or if they're in a shared branch
> > > somewhere. Therefore, I recommend doing a --no-ff merge of the branch, so it's
> > > obvious from the merge commit where they came form. They also need to be part
> > > of the diffstat.
> > >
> > > Finally, the clk patch doesn't really belong in the DT branch here. It's
> > > probably a suitable patch to send to the clk maintainers after the DT changes
> > > have gone in, i.e. for 4.9.
> > >
> > > Please respin this pull request and we'll take another look!
> > 
> > There was a discussion on IRC armlinux's channel between Lee Jones, Arnd 
> > Bergman
> > and Mark Brown about the way to proceed with this pull request.
> > 
> > As there are dependencies between the 3 critical clocks patches on 
> > Stephen Boyd's
> > branch clk-next/clk-st-critical, our STi DT and our SPI drivers which 
> > remove a temporary
> > clock hack, the decision was taken to put our DT STi fixes on top of 
> > Stephen Boyd critical clk
> >   branch and our SPI patches on the top.
> > 
> > For more details i put in attachment the IRC exchange about this.
> 
> This information belongs into the tag description, it's required for
> us to make the decision whether the branch is can be merged or not.
> 
> In particular, you need to spell out the specific dependency that
> exists between the clk patches and the dt patches.
> 
> What I understood from Lee before is that there is no such dependency
> at all and the only thing that needs the clk changes is the spi
> patch, while the DT patches and the clk patches are independent.
> 
> However, Lee's explanation was a bit ambiguous and could be interpreted
> as meaning that there is another dependency here, which was simply
> not explained.

I don't see any ambiguity?

<lag> arnd: The SPI patch depends on them both landing ... before it does
<broonie> But why not just merge all three bits via the same path with the dependencies sorted out in git?
<arnd> that would work too. lag, can you easily separate out the dt changes for this thing from the other dt changes? then the three clk changes, the respective dt changes  and the bugfix can all go into arm-soc/next/late together
<lag> broonie: That's what I suggested to start with
<lag> arnd: That works for me too
<lag> pchotard: Are you happy do to that?

... then I went on to describe to Patrice how this would look.

To recap:

Patrice would submit his normal 'machine', 'device tree' and
'defconfig' pull-requests.  None of these branches would have any
critical clock related patches contained.  He would also submit a
'late' branch, which would contain all of the critical clock
enablement.  The idea being that you would have this branch merged
late in the cycle.

Where is the confusion?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
