From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 20:47:04 +0100
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <6087001.lBonPVHV5K@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 20:25:32 Stefan Wahren wrote:
> Hi,
> 
> > Arnd Bergmann <arnd@arndb.de> hat am 28. Oktober 2014 um 20:13 geschrieben:
> > [...]
> >
> > I came up with MTD just because a grep for OTP showed most hits in there.
> > I have to admit that I didn't check whether those are actually for
> > the same kind of device or for something else that goes by the same
> > name. Having it in MTD doesn't sound too obscure though.
> >
> > There are a few other references to efuse or otp in the kernel, which means
> > that at some point we probably want to have a common subsystem and user
> > interface for this, either in MTD or standalone.
> >
> > Between drivers/misc/fsl_ocotp.c, drivers/soc/tegra/fuse and
> > drivers/mfd/ab3100-otp.c, is there any commonality that we could
> > base an abstract API on?
> 
> i don't have a answer to this question, but how about changing fsl_ocotp driver
> to driver/soc/mxs/fuse with a similiar binary interface like the tegra ones.
> 
> Does it make sense to you?

I haven't looked at the drivers, so I don't know if the tegra interface
is any better or worse than the others. Changing everyone to have the same
interface is definitely a good idea, but of course only if the unified
interface is a good one ;-)

	Arnd
