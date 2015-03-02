From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 22:49:08 +0100
Subject: [PATCH 1/5] ARM: orion: move watchdog setup to mach-orion5x
In-Reply-To: <20150302213306.GC2375@lunn.ch>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <1425328618-894030-2-git-send-email-arnd@arndb.de>
 <20150302213306.GC2375@lunn.ch>
Message-ID: <3394749.y0V7GvAChk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 22:33:06 Andrew Lunn wrote:
> On Mon, Mar 02, 2015 at 09:36:54PM +0100, Arnd Bergmann wrote:
> > The watchdog device node is created in plat-orion/common.c
> > but depends on the bridge address that is platform specific,
> > so as a preparation for orion multiplatform support, we should
> > move it out of the common code into orion5x.
> 
> If i remember correctly, RMK patchset for the Dove PMU allows the
> watchdog to be enabled for Dove.

I see. If it helps, I could change the code here to make orion_wdt_init()
take the resources as arguments like orion_i2c_init and others do.

If the goal for Russell's patches is to get everything working with
DT anyway, then the current version should work just as well.

	Arnd
