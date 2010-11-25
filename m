From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Nov 2010 16:15:08 +0900
Subject: [PATCH] ARM: s3x24xx: Fix gpiochip_add complaining.
In-Reply-To: <201011191253.58812.anarsoul@gmail.com>
References: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
	<201011191123.22255.anarsoul@gmail.com> <4CE6547A.9070309@metafoo.de>
	<201011191253.58812.anarsoul@gmail.com>
Message-ID: <00b201cb8c70$7ff96e30$7fec4a90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> On Friday 19 November 2010 12:42:02 Lars-Peter Clausen wrote:
> > Hi
> >
Hi all,

> > Well it actually causes problems on systems with external gpio
expanders,
> > because now the additional banks will take up the space which was meant
> > for the gpio expander chip and peripherals connected to it wont be
> > accessible.
> 
> Ok, but it would be nice to see some runtime soc-type detection for
gpiolib.

Yeah, I agree. We need to check SoC type for it during booting...

> s3c2410/s3c2440/s3c2442 doesn't differ too much (actually, they're same in
> gpiopart, s3c2410 lacks some gpiobanks that s3c244[0,2] have, and
difference
> in pull-up/pull-down on s3c2440 and s3c2442).
> I think it's not good to make artificial restrictions for building single
> binary kernel for these socs.
> 
> > I sent a patch[1] about this some time ago, but I guess it was never
> > applied...

Maybe you missed my e-mail...or..I missed?...anyway...
Could you please re-send it so that can get the patch via e-mail?

> 
> Try pinging Ben or Kukjin :)
> 
Thanks...

Basically, I'd like to keep single binary for S3C24XX, maybe Ben also agree
with this. But also there is some side effects, i.e., according to
mach-s3c2410/Makefile.boot, zreladdr is different. But only selected
0x30108000 as zreladdr when build time because selected CONFIG_PM_H1940 with
s3c2410_defconfig if there is no changes kernel configuration. This is just
simple example. Maybe There are many similar examples.

Hmm...anyway, we need to sort it out with keeping S3C24XX single binary.
Will think some method for this...

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
