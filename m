From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Sep 2011 20:07:39 +0100
Subject: [PATCH v2 0/2] make reinitialization of ARM core components
	possible
In-Reply-To: <20110912054140.GE1258@S2100-06.ap.freescale.net>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<4E65B71E.6060307@ti.com>
	<20110912054140.GE1258@S2100-06.ap.freescale.net>
Message-ID: <20110914190739.GE6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 01:41:41PM +0800, Shawn Guo wrote:
> OMAP and IMX6Q retains L2 cache, we have to go save/restore approach
> to work with generic cpu_suspend/resume routines.  But for platforms
> that will power off L2 during suspend, I think re-init is the easiest
> way for them get L2 back to work.

It would be much better to re-init with the same configuration values
used during the initial init - rather than using the mask + values
method which preserves whatever the boot loader gave us.

We know with quite a bit of experience that we can't rely on boot loaders
setting things up in the same way on initial boot and resume, so we should
not rely on the boot loader setting the same L2 configuration on resume
as was set during boot.
