From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Dec 2010 21:50:27 +0900
Subject: [PATCH 01/10] SMDK2416: Select MACH_SMDK, S3C_DEV_NAND,
	S3C_DEV_USB_HOST
In-Reply-To: <20101203123905.GA24691@jeknote.loshitsa1.net>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<000e01cb8fb3$73666740$5a3335c0$%kim@samsung.com>
	<20101129112228.GB7033@jeknote.loshitsa1.net>
	<015c01cb92e5$25b472a0$711d57e0$%kim@samsung.com>
	<20101203123905.GA24691@jeknote.loshitsa1.net>
Message-ID: <015f01cb92e8$ab185e40$01491ac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> On Fri, Dec 03, 2010 at 09:25:14PM +0900, Kukjin Kim wrote:
> > Yauhen Kharuzhy wrote:
> > >
> > > > > @@ -35,9 +35,12 @@ menu "S3C2416 Machines"
> > > > >  config MACH_SMDK2416
> > > > >  	bool "SMDK2416"
> > > > >  	select CPU_S3C2416
> > > > > +	select MACH_SMDK
> > > >
> > > > No need to add this here.
> > >
> > > SMDK2416 board code uses generic SMDK code, so it should be compiled
> > > also.
> > >
> > Yeah, I was confused. You're right.
> >
> > If there is no 'MACH_SMDK', happened following error with only S3C2416
> > arch/arm/mach-s3c2416/built-in.o: In function `smdk2416_machine_init':
> > arch/arm/mach-s3c2416/mach-smdk2416.c:193: undefined reference to
> > `smdk_machine_init'
> >
> > > > >  	select S3C_DEV_FB
> > > > >  	select S3C_DEV_HSMMC
> > > > >  	select S3C_DEV_HSMMC1
> > > > > +	select S3C_DEV_NAND
> > > > > +	select S3C_DEV_USB_HOST
> > > >
> > > > Probably, did you test NAND and USB_HOST on board?
> > > Yes, but one year ago. I don't have access to SMDK2416 anymore and
> usually
> > > test my patches on another S3C2416 board (e-book reader prototype).
> > >
> > (Added Banajit in To)
> >
> > Banajit, could you please test this on SMDK2416?
> >
> > > Without selection of S3C_DEV_NAND & S3C_DEV_USB_HOST mach-smdk2416.c
> > > doesn't compile, so we should either enable this platform devices
> > > definitions, either remove this devices from board file.
> > >
> >
> > Yes, if there is no 'S3C_DEV_USB_HOST', happened following error.
> > arch/arm/mach-s3c2416/built-in.o:(.init.data+0x48): undefined reference
to
> > `s3c_device_ohci'
> >
> > But I couldn't find 's3c_device_nand' device in mach-smdk2416.c and any
> > regarding NAND build failure.
> s3c_device_nand is used by arch/arm/plat-samsung/common-smdk.c
> 
plat-s3c24xx/common-smdk.c

Its failure is from typo :-(
You can find my patch for it in other my reply.

As a note, I will continue to review in next week.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
