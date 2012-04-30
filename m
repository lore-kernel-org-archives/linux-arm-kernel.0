From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Apr 2012 09:05:29 -0700
Subject: [PATCH 0/6] ARM: OMAP: hwmod: remove runtime cpu_is checking
In-Reply-To: <4F9E8CA7.8050700@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
 <4F9E8CA7.8050700@ti.com>
Message-ID: <20120430160527.GC3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120430 06:03]:
> On Saturday 28 April 2012 01:35 AM, Kevin Hilman wrote:
> > This series attempts to remove all the runtime cpu_is* checking in
> > omap_hwmod.c in favor of using function pointers initialized at init
> > time.
> > 
> > This series was motivated by the addition of support for the AM335x
> > series which was done by adding several more cpu_is* checks, and
> > provided the proverbial straw that broke the camel's back.  
> > 
> > In addition to the cleanup, this provides a much cleaner way of adding
> > additional SoC support since it no longer requires adding additional
> > runtime cpu_is* checks.
> > 
> > Boot tested on OMAP3530/Overo and OMAP4430/Panda.
> > 
> I was looking at some of these while trying to OMAP5
> support. Indeed the cpu_is_* is becoming increasingly
> no maintanable and ugly. Thanks for the series.

Also we need to start considering what happens if non-omap code
calls cpu_is_omapxxx for common zImage kernels.. So it's best to
make sure they only happen in omap specific calls during init time.

Regards,

Tony
