From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Jul 2014 09:27:44 +0200
Subject: [GIT PULL] nommu fixes for 3.17-rc1
In-Reply-To: <4782912.zqsM5TNPdE@wuerfel>
References: <20140630144355.GH14781@pengutronix.de>
 <4782912.zqsM5TNPdE@wuerfel>
Message-ID: <20140701072744.GK14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Mon, Jun 30, 2014 at 05:52:45PM +0200, Arnd Bergmann wrote:
> On Monday 30 June 2014 16:43:55 Uwe Kleine-K?nig wrote:
> > Hello Russell,
> > 
> > the following changes since commit 4c834452aad01531db949414f94f817a86348d59:
> > 
> >   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/ukl/linux.git tags/nommu-for-rmk
> > 
> > for you to fetch changes up to 7343ab2ad6772f29d6bbb286a7aa0265a7aa5d3b:
> > 
> >   ARM: make user_addr_max more robust (2014-06-30 15:48:30 +0200)
> > 
> > ----------------------------------------------------------------
> > A small collection of ARM-nommu related fixes and cleanups.
> > 
> > Regarding the small user base ("Hello, anyone out there apart from me?") and
> > the problem being fixed exists since 3.6-rc1 I don't consider the patches
> > serious enough to justify them going in before the next merge window.
> > 
> > This series makes efm32 boot again.
> > ----------------------------------------------------------------
> > 
> > I have chosen -rc3 as base because -rc1 and -rc2 don't work for me as
> > they don't have 6980c3e2514e (ARM: 8086/1: Set memblock limit for
> > nommu).
> > 
> > Uwe Kleine-K?nig (5):
> >       ARM: nommu: drop support for ARM740T, ARM940T and ARM946E-S processors
> >       ARM: nommu: don't limit TASK_SIZE
> >       ARM: nommu: simplify definition of MODULES_END
> >       ARM: nommu: drop unused Kconfig symbol DRAM_SIZE
> >       ARM: make user_addr_max more robust
> > 
> 
> I seem to have missed the patches when you posted them a couple of weeks
> ago. I do have one last-minute comment about dropping ARM740T/940T/946T:
> 
> Your reasoning is that mach-integrator now doesn't work with !MMU any more
> since it selects ARM_PATCH_PHYS_VIRT, and that no other platform uses
> these CPUs. The change to integrator was done as a preparation for
> multiplatform support and probably did not mean to remove support for !MMU
> integrator. We do plan to remove support for at91x40 in the future, which
> is the last ARM7TDMI user, and there is no upstream ARM9TDMI user nor has
> there been at least for a couple of years.
I don't care much here, so for now I will reshuffle my series to make
efm32 boot again and drop the patches removing the armv4/v4-nommu archs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
