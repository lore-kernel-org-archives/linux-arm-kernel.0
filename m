From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Feb 2010 11:58:09 +0100
Subject: pull request for .34
In-Reply-To: <20100218110135.GB8659@pengutronix.de>
References: <20100218101538.GA8659@pengutronix.de>
	<20100218102757.GA20243@n2100.arm.linux.org.uk>
	<20100218110135.GB8659@pengutronix.de>
Message-ID: <20100222105809.GA14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Feb 18, 2010 at 12:01:35PM +0100, Uwe Kleine-K?nig wrote:
> > What also isn't helpful is bundling it up with
> [...]
> >                                                the load address change
> > stuff which I'm not pulling for .34.
> That's the first objection I hear (or read) about that.  I'm not sure
> what is meant by "load address change stuff", I assume it's the runtime
> physoffset.  I look forward to more concrete feed-back.
should I repost?

I hope I didn't upset you in any way, if so it wasn't intended and I ask
you to please point out the problem that I can sort that out.
Otherwise I just assume it's lack of time. 

> >       arm/zImage: fix comments for cache_on, cache_off and cache_clean_flush
> >       arm/zImage: some comments for __armv3_mpu_cache_on
> >       arm/zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
> >       arm/zImage: annotate debug functions about corrupted registers
> >       arm/zImage: don't define unused symbol initrd_phys
> >       arm: deprecate support for old way to pass kernel parameters
> >       arm/zImage: don't hard code the stack size twice
> >       arm/uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET
> >       arm: Allow PHYS_OFFSET to be runtime determined
> >       arm: remove bit-rotten STANDALONE_DEBUG for decompressor
> >       arm/ixp2000: fix type of ixp2000_timer_interrupt
> Is it OK for you to take all but the two concering RUNTIME_PHYSOFFSET?
As I havn't got a reply up to now, I just retry without those:

The following changes since commit 499a2673713c85734a54c37dd90b4b729de399c4:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting

Uwe Kleine-K?nig (8):
      arm/zImage: fix comments for cache_on, cache_off and cache_clean_flush
      arm/zImage: some comments for __armv3_mpu_cache_on
      arm/zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
      arm/zImage: annotate debug functions about corrupted registers
      arm/zImage: don't define unused symbol initrd_phys
      arm: deprecate support for old way to pass kernel parameters
      arm/zImage: don't hard code the stack size twice
      arm: remove bit-rotten STANDALONE_DEBUG for decompressor

 arch/arm/Kconfig                        |    6 ++++++
 arch/arm/boot/compressed/Makefile       |    9 +++------
 arch/arm/boot/compressed/Makefile.debug |   23 -----------------------
 arch/arm/boot/compressed/head.S         |   26 ++++++++++++++++++--------
 arch/arm/boot/compressed/misc.c         |   27 ---------------------------
 arch/arm/kernel/Makefile                |    4 +++-
 arch/arm/kernel/compat.c                |    7 -------
 arch/arm/kernel/compat.h                |    2 --
 arch/arm/kernel/setup.c                 |   11 +++++++++++
 9 files changed, 41 insertions(+), 74 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/Makefile.debug

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
