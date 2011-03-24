From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Thu, 24 Mar 2011 14:41:42 +0100
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <4D8B4623.4010709@pengutronix.de>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<4D776B05.4010506@pengutronix.de>
	<384BC720F8C741B886DC000F067EBA20@subhasishg>
	<4D8B4623.4010709@pengutronix.de>
Message-ID: <20110324134142.GB27124@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 02:24:51PM +0100, Marc Kleine-Budde wrote:
> On 03/24/2011 02:16 PM, Subhasish Ghosh wrote:
> > Hello,
> > 
> > With make C=1 I am receiving some warnings such as:
> > 
> > warning: cast removes address space of expression
> > drivers/mfd/da8xx_pru.c:61:17: warning: incorrect type in argument 1
> > (different base types)
> > drivers/mfd/da8xx_pru.c:61:17:    expected void const volatile [noderef]
> > <asn:2>*<noident>
> > drivers/mfd/da8xx_pru.c:61:17:    got int
> > drivers/mfd/da8xx_pru.c:66:28: warning: incorrect type in argument 1
> > (different address spaces)
> 
> (Re)read the warning carefully:
> 
> You have to fix drivers/mfd/da8xx_pru.c, the first argument should be
> __void iomem *, not an int. Fix the type of the first argument. Don't
> use any casts at all, follow all warnings, eventually you will have void
> __iomem * (or struct * instead of void *) and no warnings.
> 
> > I can remove all of these by casting to (__force void  __iomem *) but is
> > this correct.
> 
> No evil casts, please :)
In addition, I learned that if a driver is not bound to a specific architecture,
you better use ioread/iowrite & friends, rather that accessing the iomemory
directly.
> 
Kurt
