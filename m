From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Sep 2013 17:49:12 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <201309292100.41701.arnd@arndb.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309272344.01386.arnd@arndb.de>
 <20130928191511.GA2548@pengutronix.de>
 <201309292100.41701.arnd@arndb.de>
Message-ID: <20130930154912.GE2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Sun, Sep 29, 2013 at 09:00:41PM +0200, Arnd Bergmann wrote:
> On Saturday 28 September 2013, Uwe Kleine-K?nig wrote:
> > On Fri, Sep 27, 2013 at 11:44:01PM +0200, Arnd Bergmann wrote:
> > > On Thursday 26 September 2013, Uwe Kleine-K?nig wrote:
> > > > I made that work now and can prepare a patch. I had to drop "depends on
> > > > !ARCH_MULTIPLATFORM" from XIP_KERNEL. That's because my machine only
> > > > works with XIP_KERNEL as it only has 4 MiB of RAM.
> > > 
> > > Ok, cool. We might run into a few problems with 'make randconfig' and
> > > 'make allyesconfig' when it becomes possible to enable XIP_KERNEL then.
> > > IIRC, there is no fundamental reason to disallow XIP_KERNEL with
> > > ARCH_MULTIPLATFORM, but I added the dependency because it causes
> > > build errors in combination with other options.
> > ah, OK. Do you have an idea to fix both?
> 
> No, I don't actually remember what problems I ran into. It may be anywhere
> from trivial to impossible to fix.
I sent a patch series (without looking much for problems :-).

> > There is a BSP publically available at
> > 
> > 	http://git-public.pengutronix.de/?p=OSELAS.BSP-EnergyMicro-Gecko.git;a=summary
> > 
> > which also includes a README file. For troubleshooting /join #efm32 on
> > freenode.
> 
> I've never tried ptxdist, but if that is known to work fine with NOMMU,
> I might just try building the base distro and running it on mach-virt.
> 
> Does this work with ELF FDPIC or do you need binfmt-flat?
I use binfmt-flat, but that's because Marc (on Cc: now) created the base
BSP for me that way. I don't know what ELF FDPIC is.

> > > Do you prevent building such a kernel in Kconfig?
> > I'm sure my Kconfig magic isn't waterproof. It took me a few tries to
> > expand the multiarch architecture selection to make v7-m selectable at
> > all.
> 
> Ok, I can have a look and give you suggestions for how it needs to be
> phrased if it currently allows broken (non-building) combinations.
You have the chance now to comment in the respective thread.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
