From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:30:59 +0100
Subject: [RFC PATCH 00/18] ARM: msm multiplatform support
In-Reply-To: <20150304221141.GA10550@fifo99.com>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <20150304221141.GA10550@fifo99.com>
Message-ID: <2137185.YgRmu1hF3r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 22:11:41 dwalker at fifo99.com wrote:
> On Wed, Mar 04, 2015 at 08:32:54PM +0100, Arnd Bergmann wrote:
> > This is my final piece of the puzzle for ARMv6/v7 multiplatform
> > support. In combination with the other patches that are now
> > at git://kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> > multiplatform-4.0-rc2 and the at91 and shmobile parts from other
> > developers, you can now build one kernel that includes all 
> > ARMv6 and ARMv7 targets we support in Linux.
> > 
> > Since mach-msm has seen very few updates over the last years,
> > it was more work to get to this point than the others, and
> > some patches are more of a band-aid than a proper solution.
> > Still, I think that each patch in the series is an improvement
> > over the status-quo and I really want to see the last one
> > merged into 4.1 and it depends on all the other ones.
> > 
> > Stephen Boyd mentioned on IRC that he has been workin on
> > a similar series, and I'm more than happy to replace some
> > of this work with patches that he has done, as long as we
> > can still have the full multiplatform support for 4.1.
> > 
> > Since a lot of the patches are nontrivial and I have not
> > been able to test any of this, I'm posting it as an RFC,
> > but I'm also very interested in people testing it.
> 
> Didn't look at it in great detail (I will eventually), but it looks like your just
> cleaning things up .. Is that accurate ?

Yes: if I did everything right, there should be no functional
changes. Most of the work was converting compile-time conditionals
into runtime conditionals, to ensure that things work when we
enable all options at once.

	Arnd
