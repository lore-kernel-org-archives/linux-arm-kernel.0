From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Dec 2011 15:15:12 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <201112091355.16720.arnd@arndb.de>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <4693507.K6tP4YDUh2@wuerfel> <20111209092300.GR4585@pengutronix.de>
 <201112091355.16720.arnd@arndb.de>
Message-ID: <20111209141512.GU4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 01:55:16PM +0000, Arnd Bergmann wrote:
> On Friday 09 December 2011, Uwe Kleine-K?nig wrote:
> > On Thu, Dec 08, 2011 at 11:55:53PM +0100, Arnd Bergmann wrote:
> > > On Thursday 08 December 2011 23:40:57 Uwe Kleine-K?nig wrote:
> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Note that there is no support yet for efm32 in mainline, so ARCH_EFM32
> > > > isn't defined.
> > > 
> > > Since the platform is not yet part of the architecture, it will have
> > > to use device tree based probing when it gets added. I would suggest
> > > only merging drivers for it that can deal with this and do not rely
> > > on platform_data.
> >
> > I feared you will say that. These machines have at most 4MiB of RAM.
> > I'll have to evaluate if dt is too heavy for them.
> 
> What's the state of the platform code? Is this based on Catalin's
> Cortex-M3 tree? I've heard a few people express interest in getting
> various M3 based SoCs supported mainline and I think that would
> be a good idea, but I would also expect that device tree is one
> of the lesser problems here.
Yes, I took a few patches from there and rebased them to 3.2-rc3. The
patches I have from Catalin are:

131dbba Cortex-M3: Add base support for Cortex-M3
48cc6a8 Cortex-M3: Add support for exception handling
2aebf66 Cortex-M3: Add NVIC support
75bf249 Cortex-M3: Allow the building of Cortex-M3 kernel port
66dcc1e Cortex-M3: Add VFP support
a541241 [ARM] Do not call flush_cache_user_range with mmap_sem held
6083ea7 ARM: Handle instruction cache maintenance fault properly

I didn't look into these deeply yet to check how ready they are for
mainline, but my machine boots to a prompt (which doesn't allow to start
anything because it doesn't have enough memory to allocate the stack for
a new program. I will soon get a machine that has 4MiB of RAM instead of
the 1MiB I have now).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
