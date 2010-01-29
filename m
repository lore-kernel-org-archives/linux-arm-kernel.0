From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2010 22:13:44 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
Message-ID: <20100129211343.GA21364@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 04:12:08PM -0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org 
> > Behalf Of Catalin Marinas
> 
> > For whatever reason, with commit e7db7b4270 (arm: add support for
> > LZO-compressed kernels) if the kernel Image goes beyond a certain size
> > it fails to uncompress. Reverting this commit solves the problem.
> > Removing some random kernel features also solves the uncompressing as
> > the kernel image gets smaller.
> 
> My experiments appear to show that the problem appears as the kernel image
> grows above 2MB
> 
> When size is 2084132 (1.9MB) it boots
> 
> If I add something to make it slightly bigger (like Control Group
> Support)...
> 
> then size is 2103332 (2.005MB) and it fails to uncompress.
And does increasing the stack size helps?

e.g. s/4096/8192/ in arch/arm/boot/compressed/head.S (you need to change
two lines).

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
