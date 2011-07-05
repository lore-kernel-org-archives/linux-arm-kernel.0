From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:25:47 +0200
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <20110705053229.GC27909@game.jcrosoft.org>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<4E118679.4090908@atmel.com>
	<20110705053229.GC27909@game.jcrosoft.org>
Message-ID: <201107051325.47417.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > You have convinced me.
> > But I will have to remove the other dependencies that I mentioned before
> > in the thread.
> > 
> > We can drop this patch.
> I prefer to hide the platform specific driver other wise we will have a huge
> menu entry in Kconfig with unrelated drivers that can not be used at all on
> the selected mach

I fear it's too late for that. You already have to decide on many thousands
of configuration options, most of which are totally irrelevant for a
particular system.

IMHO, the two much better ways to deal with SOC-specific device drivers
are defconfig files and/or specific defaults, like

config ABX500_CORE
        bool "ST-Ericsson ABX500 Mixed Signal Circuit register functions"
        default ARCH_U300 || ARCH_U8500

This lets everybody choose whether they would like to build the driver
or not, which is very useful for allyesconfig/allnoconfig/randconfig
builds. At the same time, the default gets it right in almost all
other cases.

	Arnd
