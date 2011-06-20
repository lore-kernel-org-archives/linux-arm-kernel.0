From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Jun 2011 03:17:19 -0700
Subject: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
In-Reply-To: <20110620095603.GC2082@n2100.arm.linux.org.uk>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092334.357.3701.stgit@kaulin>
	<20110620095603.GC2082@n2100.arm.linux.org.uk>
Message-ID: <20110620101718.GI23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110620 02:51]:
> On Mon, Jun 20, 2011 at 02:23:34AM -0700, Tony Lindgren wrote:
> > These will be needed when dmtimer platform init code gets split
> > for omap1 and omap2+. These will also be needed for separate
> > sys_timer init and driver init for the rest of the hardware timers
> > in the following patches. No functional changes.
> 
> If dmtimer.c is the only user of these definitions, then its quite correct
> for them to be in there.  If not, they should be in dmtimer.h in the local
> directory - they're private definitions to the .c file and so should not
> be exported outside of that .c file.

There will be more patches coming to make the rest of the dmtimer
code be just a regular device driver. These inline functions will
be used by sys_timer related code, and dmtimer device driver.

This way we can make the dmtimer a loadable module and don't need
to initialize any of that early.

Tony
