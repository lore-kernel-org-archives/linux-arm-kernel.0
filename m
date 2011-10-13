From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Oct 2011 09:39:03 -0400 (EDT)
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111013082836.GG21648@n2100.arm.linux.org.uk>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<1837446.fiK2eIOO53@wuerfel>
	<20111013082836.GG21648@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1110130932350.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:

> On Wed, Oct 12, 2011 at 10:30:11AM +0200, Arnd Bergmann wrote:
> > On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> > > On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> > > 
> > > > I've stuck them into the arm-soc tree for now, so we get linux-next
> > > > coverage, but I won't send them to Linus this way because then we
> > > > would get the same commits twice in the history.
> > > 
> > > Could you please do the same with the following:
> > > 
> > >   git://git.linaro.org/people/nico/linux.git mach_memory_h
> > > 
> > > Russell pulled it at some point, and dropped it due to concerns about 
> > > repeated conflict resolutions (or so I presume).  I just did a test 
> > > merge between your for-next branch and the above and that looked trivial 
> > > enough.
> > 
> > Ok, done.
> 
> Bypassing maintainers stinks - especially when there are unaddressed
> comments outstanding.  Nicolas has "simplified" my objections in this
> request for you to pull - and has completely ignored the problem that
> it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
> with no way for that to be provided.

I also told you that EP93xx doesn't use ZBOOT_ROM anywhere, and that 
this was approved by the EP93xx maintainers.

Furthermore I said that I intended to make ZBOOT_ROM dependent on 
CONFIG_PHYS_OFFSET, given that PHYS_OFFSEt and zreladdr are intimately 
related which I also explained previously.  This doesn't have to go in 
right away though.  But if this is one of your _requirements_, I'd have 
appreciated you made it clearer instead of letting me to dry without any 
feedback, especially when I re-re-re-pinged you last week and before.

So much for having lectured me on proper communication.


Nicolas
