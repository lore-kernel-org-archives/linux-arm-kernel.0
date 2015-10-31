From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Oct 2015 19:12:00 -0700
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <56307B33.90608@samsung.com>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
 <56307B33.90608@samsung.com>
Message-ID: <20151031021200.GA2189@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 04:37:23PM +0900, Krzysztof Kozlowski wrote:
> On 24.10.2015 06:26, Kukjin Kim wrote:
> > The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> > 
> >   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-driver
> > 
> > for you to fetch changes up to c612d5a7785b307df96938d590c3a1edfb624ccf:
> > 
> >   cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs (2015-10-24
> > 04:34:50 +0900)
> > 
> > ----------------------------------------------------------------
> > Samsung driver udpates for v4.4
> > 
> > - add support for exynos SROM controller DT based driver
> >   (drivers/soc/samsung/exynos-srom.c)
> >   : Since the exynos SROM registers are used during Suspend to RAM
> >     so the exynos SROM driver handles the S2R and then we can remove
> >     static mapping for SROM registers.
> >   : Pankaj tested boot and S2R functionality on Peach-Pi chromebook
> >   : Pavel tested on SMDK5410 board
> >   : Krzysztof tested on Trats2 (exynos4412) board
> > - update Maintainer entry accordingly
> > - remove superfluous CONFIG_PM ifdefs with Viresh's ack
> > 
> > ----------------------------------------------------------------
> > Bartlomiej Zolnierkiewicz (1):
> >       cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs
> > 
> > Pankaj Dubey (8):
> >       ARM: EXYNOS: remove unused static mapping of CMU for exynos5
> >       ARM: EXYNOS: code cleanup in map.h
> >       dt-bindings: add exynos-srom device tree binding
> >       ARM: dts: add SROM device node for exynos4
> >       ARM: dts: add SROM device node for exynos5
> 
> Hi Olof and Kukjin,
> 
> I see that this pull request was not pulled yet. (Un)Fortunately I
> spotted one mistake in DTS changes above - the length of mapped region
> is too small by one word. This does not produce any visible effect but
> actually is wrong because driver will read from unmapped memory.

Yeah, I started looking now at why I didn't merge it since I had just not
touched it nor replied to it.

It looks like it contains an slight jumble of patches. It modifies DT
contents, which we always ask to get in the dt branch.

Please resend after -rc1 and we'll merge this for 4.5.


Thanks,


-Olof
