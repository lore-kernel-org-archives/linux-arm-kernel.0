From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Nov 2010 09:51:44 +0900
Subject: [PATCH] ARM: S3C64XX: fix uart clock setup for mini6410/real6410
In-Reply-To: <4CE15522.1050901@gmail.com>
References: <20101107195738.9835.47554.stgit@localhost6.localdomain6>
	<4CE15522.1050901@gmail.com>
Message-ID: <00d701cb8528$72d09750$5871c5f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> Hi Kukjin,
> 
Hi Darius :-)

> could you please add this to your tree?
> 
Ok...will apply.
And this will be sent to upstream next -rc pull request.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> On 11/07/2010 09:58 PM, Darius Augulis wrote:
> > Don't rewrite clock config in UCON preconfigured by
> > bootloader. No need to set 10th bit in UCON because
> > [11:10] 2'b00 means source clock is PCLK too.
> > If set, console does not work if bootloader
> > has preconfigured [11:10] with 2'b00.
> > If not set, console works with any bootloader
> > config value (2'bxx).
> > More information about clock setup in UCON is available
> > in "S3C6410X RISC Microprocessor User's Manual,
> > Revision 1.20" p. 31-13 (Chapter 31.6.2
> > UART CONTROL REGISTER).
> >
> > Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
> > ---
> >   arch/arm/mach-s3c64xx/mach-mini6410.c |    2 +-
> >   arch/arm/mach-s3c64xx/mach-real6410.c |    2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-
> s3c64xx/mach-mini6410.c
> > index 3864afa..5823976 100644
> > --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> > @@ -45,7 +45,7 @@
> >
> >   #include<video/platform_lcd.h>
> >
> > -#define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
> > +#define UCON S3C2410_UCON_DEFAULT
> >   #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE |
S3C2410_LCON_STOPB)
> >   #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
> >
> > diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
> s3c64xx/mach-real6410.c
> > index f9ef9b5..4957ab0 100644
> > --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> > @@ -46,7 +46,7 @@
> >
> >   #include<video/platform_lcd.h>
> >
> > -#define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
> > +#define UCON S3C2410_UCON_DEFAULT
> >   #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE |
S3C2410_LCON_STOPB)
> >   #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
