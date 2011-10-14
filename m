From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Oct 2011 22:32:26 -0400 (EDT)
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <4E976F9A.80203@gmail.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<1837446.fiK2eIOO53@wuerfel>
	<20111013082836.GG21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110130932350.17040@xanadu.home>
	<4E976F9A.80203@gmail.com>
Message-ID: <alpine.LFD.2.02.1110132158090.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Oct 2011, Ryan Mallon wrote:

> On 14/10/11 00:39, Nicolas Pitre wrote:
> 
> > On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:
> > 
> >> On Wed, Oct 12, 2011 at 10:30:11AM +0200, Arnd Bergmann wrote:
> >>> On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> >>>> On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> >>>>
> >>>>> I've stuck them into the arm-soc tree for now, so we get linux-next
> >>>>> coverage, but I won't send them to Linus this way because then we
> >>>>> would get the same commits twice in the history.
> >>>>
> >>>> Could you please do the same with the following:
> >>>>
> >>>>   git://git.linaro.org/people/nico/linux.git mach_memory_h
> >>>>
> >>>> Russell pulled it at some point, and dropped it due to concerns about 
> >>>> repeated conflict resolutions (or so I presume).  I just did a test 
> >>>> merge between your for-next branch and the above and that looked trivial 
> >>>> enough.
> >>>
> >>> Ok, done.
> >>
> >> Bypassing maintainers stinks - especially when there are unaddressed
> >> comments outstanding.  Nicolas has "simplified" my objections in this
> >> request for you to pull - and has completely ignored the problem that
> >> it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
> >> with no way for that to be provided.
> > 
> > I also told you that EP93xx doesn't use ZBOOT_ROM anywhere, and that 
> > this was approved by the EP93xx maintainers.
> 
> As the less active of the two EP93xx maintainers I didn't agree to this.
> I don't know if Hartley did, but I can't find anything from him in a
> quick search of the list. I have Cc'ed him.

See http://article.gmane.org/gmane.linux.ports.arm.kernel/124151 
Granted, while he agreed to the removal of the zreladdr definitions, 
reading this again he didn't _explicitly_ agree to the disabling of 
ZBOOT_ROM.  I didn't mention it either, so let's put that on a 
miscommunication on my part.

> I don't have time to follow this issue in depth, but from my vague
> understanding ZBOOT_ROM is unlikely to be used on EP93xx, but still
> _possible_ to use. Therefore we should not be removing support for
> ZBOOT_ROM on EP93xx in case there are some users out there.

No worry, I've now excluded EP93xx from my series.

My intention never was to permanently remove ZBOOT_ROM support.  But 
because of the EP93xx memory peculiarities, it will have to wait until 
the ZBOOT_ROM config is moved away from zreladdr.

That means you won't be able to have a single zImage for all the EP93xx 
boards with different memory banks just yet.


Nicolas
