From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 May 2015 08:49:42 +0200
Subject: [PATCH] ARM: footbridge: enable dc21285 mtd map in defconfig
In-Reply-To: <20150528210520.GE2067@n2100.arm.linux.org.uk>
References: <20150528192238.GQ27753@ld-irv-0074>
 <1432842380-4187-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150528195558.GR27753@ld-irv-0074>
 <20150528210520.GE2067@n2100.arm.linux.org.uk>
Message-ID: <20150529064942.GB18985@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 10:05:20PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 28, 2015 at 12:55:58PM -0700, Brian Norris wrote:
> > On Thu, May 28, 2015 at 09:46:20PM +0200, Uwe Kleine-K?nig wrote:
> > > This driver fails to build since release 3.2. Improve compile coverage
> > > by enabling this driver in the footbridge defconfig
> > 
> > Actually, it did build, but it just had alarming warnings. I don't think
> > those warnings actually affected anything at runtime, except for lock
> > debugging (if enabled).
> > 
> > But anyway, the change looks good, and I'm doing this in my local build
> > tests now, so:
> > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > Acked-by: Brian Norris <computersforpeace@gmail.com>
> 
> I'd say no to this - some boards have old (28F008) flash on them, which
> (iirc) doesn't take kindly to being probed by MTD.
Is this a bug? I'd say keeping the driver disabled in the defconfig just
papers over a problem.
Maybe modify the driver to not probe unless a kernel parameter is given?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
