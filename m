From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 09:28:36 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <1837446.fiK2eIOO53@wuerfel>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<1837446.fiK2eIOO53@wuerfel>
Message-ID: <20111013082836.GG21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 10:30:11AM +0200, Arnd Bergmann wrote:
> On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> > On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> > 
> > > I've stuck them into the arm-soc tree for now, so we get linux-next
> > > coverage, but I won't send them to Linus this way because then we
> > > would get the same commits twice in the history.
> > 
> > Could you please do the same with the following:
> > 
> >   git://git.linaro.org/people/nico/linux.git mach_memory_h
> > 
> > Russell pulled it at some point, and dropped it due to concerns about 
> > repeated conflict resolutions (or so I presume).  I just did a test 
> > merge between your for-next branch and the above and that looked trivial 
> > enough.
> 
> Ok, done.

Bypassing maintainers stinks - especially when there are unaddressed
comments outstanding.  Nicolas has "simplified" my objections in this
request for you to pull - and has completely ignored the problem that
it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
with no way for that to be provided.

Moreover, it forces EP93xx to always use AUTO_ZRELADDR, but you can
still select ZBOOT_ROM, which is an invalid combination.

Not only that, I'm carrying a patch from Sascha which detects the
multiple-zreladdr problem and prevents building such kernels and this
conflicts with that patch.

So I'm not pulling Nicolas' mach_memory_h branch until he comes to his
senses.  I had pointed this out but got a rather stroppy replies in
return.
