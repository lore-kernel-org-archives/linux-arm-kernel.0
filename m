From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Thu, 7 May 2015 15:04:07 +0000
Subject: [PATCH 1/1] ARM: imx: Correct the comments in time.c
In-Reply-To: <20150507125858.GH3162@dragon>
References: <1430343627-60688-1-git-send-email-shenwei.wang@freescale.com>
 <20150507125858.GH3162@dragon>
Message-ID: <BL2PR03MB370C59A9B6D5B896BEBA75083DF0@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thank you for your time. 
Your changes are fine. It seems there is no perfect solution for this kind of issue.

Regards,
Shenwei

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: 2015?5?7? 7:59
> To: Wang Shenwei-B38339
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: imx: Correct the comments in time.c
> 
> On Wed, Apr 29, 2015 at 04:40:27PM -0500, Shenwei Wang wrote:
> > The comments were corrected as the following to reflect the real
> > situation of Freescale MXC timer IP block.
> > There are totally 4 version of the timer on Freescale i.MX SoCs.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> > ---
> >  arch/arm/mach-imx/time.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c index
> > acb1ff5..b1698e1 100644
> > --- a/arch/arm/mach-imx/time.c
> > +++ b/arch/arm/mach-imx/time.c
> > @@ -38,9 +38,11 @@
> >  #include "hardware.h"
> >
> >  /*
> > - * There are 2 versions of the timer hardware on Freescale MXC hardware.
> > - * Version 1: MX1/MXL, MX21, MX27.
> > - * Version 2: MX25, MX31, MX35, MX37, MX51
> > + * There are 4 versions of the timer hardware on Freescale MXC hardware.
> > + * Version 0: MX1/MXL
> > + * Version 1: MX21, MX27.
> > + * Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q(rev1.0)
> > + * Version 3: MX6DL, MX6SX, MX6Q(rev1.1+)
> 
> This is the problem with version numbers.  Version numbers defined by software
> are too arbitrary and could conflict with the ones defined by IP design (i.e. IPUv3)
> some day.  Just for example, if some day GPTv2 IP comes with some significant
> design changes, "v2" will becomes a source of confusion between software and
> hardware.  It's even worse if we already defined fsl,gpt-v2 as the device tree
> compatible.  That's why we can only use the version number defined by
> hardware in device tree binding.  If no hardware version is given, the best bet
> would be use SoC name in the bindings to specify the particular programming
> model of the IP block.
> 
> I applied patch to drop the version numbers as below.
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c index
> acb1ff577cda..ab5ee1c445f3 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -38,9 +38,11 @@
>  #include "hardware.h"
> 
>  /*
> - * There are 2 versions of the timer hardware on Freescale MXC hardware.
> - * Version 1: MX1/MXL, MX21, MX27.
> - * Version 2: MX25, MX31, MX35, MX37, MX51
> + * There are 4 versions of the timer hardware on Freescale MXC hardware.
> + *  - MX1/MXL
> + *  - MX21, MX27.
> + *  - MX25, MX31, MX35, MX37, MX51, MX6Q(rev1.0)
> + *  - MX6DL, MX6SX, MX6Q(rev1.1+)
>   */
> 
>  /* defines common for all i.MX */
> 
> Shawn
