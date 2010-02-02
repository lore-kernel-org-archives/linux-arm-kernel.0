From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 10:01:21 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
Message-ID: <20100202090121.GC22848@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Colin,

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
What do you mean saying "kernel image"?  zImage, Image, vmlinux,
arch/arm/boot/compressed/vmlinux?

So where do you place your zImage, what is zreladdr, how big is your
RAM?

I'm able to boot with an image having:

	$ git describe
	v2.6.33-rc6
	$ ls -l vmlinux arch/arm/boot/compressed/vmlinux arch/arm/boot/compressed/vmlinux arch/arm/boot/uImage arch/arm/boot/zImage 
	-rwxr-xr-x 1 ukl ptx  2493585 2010-02-02 09:53 arch/arm/boot/compressed/vmlinux
	-rwxr-xr-x 1 ukl ptx  2493585 2010-02-02 09:53 arch/arm/boot/compressed/vmlinux
	-rw-r--r-- 1 ukl ptx  2417764 2010-02-02 09:53 arch/arm/boot/uImage
	-rwxr-xr-x 1 ukl ptx  2417700 2010-02-02 09:53 arch/arm/boot/zImage
	-rwxr-xr-x 1 ukl ptx 49218631 2010-02-02 09:50 vmlinux

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
