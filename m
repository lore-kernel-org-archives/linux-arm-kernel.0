From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 25 Feb 2010 13:59:14 -0800 (PST)
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <1267096333.2722.44.camel@realization>
Message-ID: <210155.75899.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

--- On Thu, 2/25/10, Alberto Panizzo <maramaopercheseimorto@gmail.com> wrote:

> From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> Subject: Re: [PATCH] mx31pdk: Add NAND support
> To: "Fabio Estevam" <fabioestevam@yahoo.com>
> Cc: linux-arm-kernel at lists.infradead.org, s.hauer at pengutronix.de
> Date: Thursday, February 25, 2010, 9:12 AM
> Hi Fabio,
> 
> On mer, 2010-02-24 at 16:58 -0800, Fabio Estevam wrote:
> > Add NAND support to MX31PDK board.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >? arch/arm/mach-mx3/mach-mx31_3ds.c |? ?
> 7 +++++++
> >? 1 files changed, 7 insertions(+), 0
> deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
> b/arch/arm/mach-mx3/mach-mx31_3ds.c
> > index b88c18a..2d78754 100644
> > --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> > +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> > @@ -34,6 +34,7 @@
> >? #include <mach/board-mx31pdk.h>
> >? #include <mach/imx-uart.h>
> >? #include <mach/iomux-mx3.h>
> > +#include <mach/mxc_nand.h>
> >? #include "devices.h"
> >? 
> >? /*!
> > @@ -80,6 +81,11 @@ static struct resource
> smsc911x_resources[] = {
> >? ??? },
> >? };
> >? 
> > +static struct mxc_nand_platform_data
> mx31pdk_nand_board_info = {
> > +??? .width = 1,
> > +??? .hw_ecc = 1,
> > +};
> > +
> 
> Are you sure that this works? Don't you see a lot of Bad
> blocks reports
> in boot messages?

I followed the same approach used on other i.MX boards. This is what I see:
...
NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V 8-bit)                                                                              
Scanning device for bad blocks                                                  
Bad eraseblock 42 at 0x000000540000                                             
Bad eraseblock 125 at 0x000000fa0000                                            
Bad eraseblock 887 at 0x000006ee0000                                            
Bad eraseblock 1750 at 0x00000dac0000                                           
Bad eraseblock 2046 at 0x00000ffc0000                                           
Bad eraseblock 2047 at 0x00000ffe0000                                           
Registering mxc_nand as whole device  

If I define it as:

static struct mxc_nand_platform_data mx31pdk_nand_board_info = {
	.width = 1,
	.hw_ecc = 1,
	.flash_bbt =1,
};

The bad block messages go away. 

What would be the correct way?

Thanks,

Fabio Estevam




 


      
