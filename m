From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Sep 2011 10:51:54 +0800
Subject: [PATCH 0/6] add initial imx6q support
In-Reply-To: <2043782.jegSLqAsTH@wuerfel>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<2043782.jegSLqAsTH@wuerfel>
Message-ID: <20110907025152.GA8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 08:28:39PM +0200, Arnd Bergmann wrote:
> On Tuesday 06 September 2011 17:58:34 Shawn Guo wrote:
> > This patch series adds the initial support for imx6q, which is a
> > Cortex-A9 MPCore (4 cores) SoC.
> > 
> > It's based on v3.1-rc4 with the patches below applied.
> > 
> >  * [PATCH v2 0/5] Convert DEBUG_LL UART selection to a Kconfig choice
> >    http://thread.gmane.org/gmane.linux.ports.arm.kernel/129702
> > 
> >  * [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
> >    http://article.gmane.org/gmane.linux.kernel/1164401
> > 
> >  * [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
> >    http://article.gmane.org/gmane.linux.ports.arm.kernel/130878
> > 
> >  * [RFC PATCH 0/3] Yet another GIC OF binding series
> >    http://thread.gmane.org/gmane.linux.drivers.devicetree/7226
> > 
> > For suspend/resume support, it needs the following extra patches
> > applied.
> > 
> >  * [PATCH v2 0/2] make reinitialization of ARM core components possible
> >    http://thread.gmane.org/gmane.linux.ports.arm.kernel/131356
> > 
> >  * [PATCH v2 0/5] CPU PM notifiers
> >    http://thread.gmane.org/gmane.linux.ports.arm.kernel/131212/focus=131353
> 
> Hi Shawn,
> 
> We've talked about it before, but I don't remember the outcome. Can you
> explain (and add to the above text) a short explanation of why this is
> in the mach-imx directory, rather than the mach-mx5 (which probably is
> closer to mx6 than mx3 is) or a new mach-mx6?
> 
As Uwe mentioned, our long term view on imx sub-architecture is to move
mach-mx5 into mach-imx, so that we can have single mach folder for imx,
though whether we eventually move plat-mxc into mach-imx or not is
another thing we can think about later.

I will add something about that in the cover letter with the next post.

-- 
Regards,
Shawn
