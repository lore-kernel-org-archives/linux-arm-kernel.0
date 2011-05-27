From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 27 May 2011 16:19:27 +0800
Subject: [PATCH] ARM: mxs_defconfig: Remove locking debug config options
In-Reply-To: <20110526120055.GB14257@pengutronix.de>
References: <20110525141624.GE2408@S2100-06.ap.freescale.net>
	<1306391203-29338-1-git-send-email-shawn.guo@linaro.org>
	<20110526120055.GB14257@pengutronix.de>
Message-ID: <20110527081927.GA30146@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 02:00:55PM +0200, Uwe Kleine-K?nig wrote:
> On Thu, May 26, 2011 at 02:26:43PM +0800, Shawn Guo wrote:
> > The amba-pl011 driver assumes that clk_enable/disable are atomic, but
> > currently it's not the case on mxs.  There are lock debug warnings
> > seen when serial console does power management.
> > 
> > The patch removes locking debug config options to get rid of the
> > warnings.  They can be turned on later when new clock framework sorts
> > the locking thing out.
> I'd keep the debug messages enabled. Just because you disable them the
> problem isn't gone. This way it's a bit more certain that it gets fixed
> ...
> 
This is a well known problem.  Migrating to new clock framework is on
top of my TODO list, and I will do once it comes.  Before that, all
we can do is looking at the warning message every single time we boot
the kernel.  It is not helping anything but getting valuable debugging
message invisible in the flooding lock warnings.

-- 
Regards,
Shawn
