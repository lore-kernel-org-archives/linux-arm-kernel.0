From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Oct 2011 18:29:25 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <2414781.rlNqTThJUN@wuerfel>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
Message-ID: <20111012172925.GD21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 09:25:19PM +0200, Arnd Bergmann wrote:
> On Tuesday 11 October 2011 19:48:21 Will Deacon wrote:
> > On Tue, Oct 11, 2011 at 04:09:15PM +0100, Will Deacon wrote:
> > > For the cpu-mapping, I depend on:
> > > 
> > > ARM: 7011/1: Add ARM cpu topology definition
> > > ARM: 7060/1: smp: populate logical CPU mapping during boot
> > > ARM: 7061/1: gic: convert logical CPU numbers into physical numbers
> > > 
> > > which I can only see in Russell's for-next branch.
> > > 
> > > For the debug-ll stuff, I depend on:
> > > 
> > > ARM: 7072/1: debug: use kconfig choice for selecting DEBUG_LL UART
> > > 
> > > and conflict with:
> > > 
> > > ARM: 7097/1: debug: Move DEBUG_ICEDCC into the DEBUG_LL choice
> > > ARM: 7096/1: debug: Add UART1 config choices
> > > ARM: 7116/1: debug: provide dummy default option for DEBUG_LL UART choice
> > > ARM: 7073/1: debug: augment DEBUG_LL Kconfig help to clarify behaviour
> > 
> > I've stuck a debug-ll branch and a cpu-mapping branch here:
> > 
> > git://github.com/wdeacon/linux-wd.git
> 
> Ok, thanks.
> 
> > (I finally gave up with my old broken git server!)
> > 
> > These branches are based against -rc9 and I've cherry-picked the
> > dependencies from Russell's for-next branch. I'm not sure that's good for
> > anything, but it at least helps to show what's already in Russell's tree
> > and what's currently outstanding.
> 
> I've stuck them into the arm-soc tree for now, so we get linux-next
> coverage, but I won't send them to Linus this way because then we
> would get the same commits twice in the history.
> 
> Russell, would be mind putting the 8 patches that Will listed above
> into the devel-stable or some other non-rebasing branch so we can
> rebase Will's patches on top of that?
> 
> Alternatively, if you prefer you could also throw them out of your
> tree so I can send them to Linus, or you could pull the two patch
> series from Will into your arm tree so I can drop them completely.

At this point in the game (which I guess is that the merge window is
very likely going to open this evening), I'm minded to just say no, my
tree is now frozen, and that's that - especially as there's a bunch of
_horrible_ merges involved in rebuilding that stuff now.

Especially as its going to take me a few days before I start looking
at touching my git tree as I'll be sorting through the email backlog.
