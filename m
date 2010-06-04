From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Jun 2010 17:09:59 +0300
Subject: [PATCH] mxc: Fix pad names for imx51
In-Reply-To: <20100604105347.GA2982@matterhorn.lan>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100604085320.GB25357@pengutronix.de>
	<20100604105347.GA2982@matterhorn.lan>
Message-ID: <20100604140959.GB2982@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 04, Amit Kucheria wrote:
> On 10 Jun 04, Sascha Hauer wrote:
> > On Thu, Jun 03, 2010 at 08:05:44PM +0800, Jason Wang wrote:
> > >  
> > > -#define MX51_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, 3, 0x0, 0, NO_PAD_CTRL)
> > > -#define MX51_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, 3, 0x0, 0, NO_PAD_CTRL)
> > > +#define MX51_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, IOMUX_CONFIG_ALT1, 0x9f4, 4, MX51_UART3_PAD_CTRL)
> > > +#define MX51_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, IOMUX_CONFIG_ALT1, 0x0, 0, MX51_UART3_PAD_CTRL)
> > 
> > Urgs, there really is something wrong here.
> > 
> > First of all, this define should be named MX51_PAD_UART3_RXD__GPIO_1_22
> > as it describes the pad UART3_RXD in GPIO_1_22 mode. This seems to be
> > wrong with many (all?) defines in this file. Amit, you should have read
> > the comment ontop of this file which you copied from the i.MX35 part:
> 
> I'll admit that I was not completely conversant with the naming scheme then.
> All the GPIO-related names have been reversed. The others seem fine.
> 
> > /*
> >  * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
> >  * If <padname> or <padmode> refers to a GPIO, it is named
> >  * GPIO_<unit>_<num> see also iomux-v3.h
> >  */
> 
> There was a comment below this:
> /*
>  * FIXME: This was converted using scripts from existing Freescale code to
>  * this form used upstream. Need to verify the name format.
>  */
> 
> I obviously reversed the naming for all the GPIO pads.
> 
> > This should be fixed before doing any other change to this file.
> 
> I'm preparing a patch now.
> 

Please find the patch attached.

You can see the output of diff without the whitespace changes here:
http://paste.ubuntu.com/444628/
