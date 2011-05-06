From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 May 2011 10:04:49 +0100
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110506090449.GA18408@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> a flush ARM probably does, too, no?
> If so, what it the right thing to do? Implement flush_dcache_range for
> ARM (just wrapping flush_dcache_page?)?

On ARM, we assume all new pages have dirty dcache, which allows us to
neatly end the ever-increasing quantity of drivers which need to be
patched to work on ARM.  PowerPC doesn't do this.
