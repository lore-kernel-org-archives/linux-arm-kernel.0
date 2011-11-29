From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 03:03:38 +0100
Subject: [AT91 PULL] ioremap pull request for 3.3
In-Reply-To: <201111281846.22837.arnd@arndb.de>
References: <20111123171022.GB15531@game.jcrosoft.org>
 <201111281846.22837.arnd@arndb.de>
Message-ID: <20111129020338.GJ15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:46 Mon 28 Nov     , Arnd Bergmann wrote:
> On Wednesday 23 November 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >         this pull containt the first patch series that rework the base address
> >         of a lots of drivers (aic, rtc, gpio, ecc, dma, rtt, pit, smc, shutdown, watchdog, dbgu)
> >         to allow the multi soc and simplify the adding of the DT
> >         
> > The following changes since commit 8454badc89ed455990b1a060d9e4ed890b9e162c:
> > 
> >   ARM: at91: rename at91sam9260ek_defconfig to at91sam9260_defconfig (2011-11-23 02:45:57 +0800)
> > 
> > are available in the git repository at:
> >   git://github.com/at91linux/linux-at91.git for-arnd-3.3-ioremap
> 
> Applied into next/cleanup, thanks!
> 
> I noticed that you introduce a bunch of new references to __raw_writel
> when you get rid of at91_sys_write uses in drivers. This is obviously
> the safe choice since it keeps the code behavior close to what it was.
> 
> However, I think it would be good to use writel_relaxed there,
> to make the accesses more well-defined. Maybe you can do an add-on
> patch to convert the various new accessor macros over to that.
 I've a pull for the reset and DT to prepare first and will do

Best Regards,
J.
