From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 23:18:56 +0000
Subject: [PATCH 1/5] ARM: orion: move watchdog setup to mach-orion5x
In-Reply-To: <3394749.y0V7GvAChk@wuerfel>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <1425328618-894030-2-git-send-email-arnd@arndb.de>
 <20150302213306.GC2375@lunn.ch> <3394749.y0V7GvAChk@wuerfel>
Message-ID: <20150302231856.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 10:49:08PM +0100, Arnd Bergmann wrote:
> On Monday 02 March 2015 22:33:06 Andrew Lunn wrote:
> > On Mon, Mar 02, 2015 at 09:36:54PM +0100, Arnd Bergmann wrote:
> > > The watchdog device node is created in plat-orion/common.c
> > > but depends on the bridge address that is platform specific,
> > > so as a preparation for orion multiplatform support, we should
> > > move it out of the common code into orion5x.
> > 
> > If i remember correctly, RMK patchset for the Dove PMU allows the
> > watchdog to be enabled for Dove.
> 
> I see. If it helps, I could change the code here to make orion_wdt_init()
> take the resources as arguments like orion_i2c_init and others do.
> 
> If the goal for Russell's patches is to get everything working with
> DT anyway, then the current version should work just as well.

Well, right now I don't know how to progress the PMU patches.  From
what I remember, there was agreement on where to put the PMU driver,
but there's still a problem with the PM domain binding code.  That
issue just ended up stopping being discussed.

Is it no surprise, therefore, that it takes literally years to get
stuff into mainline kernels, and people get pissed off and end up
maintaining stuff outside of mainline?

commit b6c7ff35be7131abe7c83a22a87bbb2343f61a5a
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon Mar 3 14:49:14 2014 +0000

    pm: domains: quieten down generic pm domains

One year old for a simple patch... Several other patches in that set
date from April 2014 too...

Mainline kernel development sucks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
