From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue, 8 Jun 2010 00:04:48 +0300
Subject: [PATCH] mxc: Fix pad names for imx51
In-Reply-To: <4C0D5996.9050906@boundarydevices.com>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100604085320.GB25357@pengutronix.de>
	<20100604105347.GA2982@matterhorn.lan>
	<20100604140959.GB2982@matterhorn.lan>
	<4C0D5996.9050906@boundarydevices.com>
Message-ID: <20100607210448.GA2446@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 07, Troy Kisky wrote:

> > On 10 Jun 04, Amit Kucheria wrote:
> >

<snip>

> > +#define MX51_PAD_CSPI1_SCLK__GPIO_4_27		IOMUX_PAD(0x614, 0x224,  3, 0x0,   0, NO_PAD_CTRL)

<snip>

> > +#define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_3__GPIO_1_3		IOMUX_PAD(0x7D8, 0x3D0, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, NO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
> > +#define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 0, 0x0,   0, NO_PAD_CTRL)
> 
> Why all the stuttering?
> Isn't MX51_PAD_GPIO_1_9 or MX51_PAD_DISP2_DAT15 descriptive enough?
> 

Just following the convention use in the rest of imx devices. See the
following comment at the top of the file:

/*
 * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
 * If <padname> or <padmode> refers to a GPIO, it is named
 * GPIO_<unit>_<num> see also iomux-v3.h
 */

We could use the short names for pads being used in their "native mode".
But as soon as we use the pad in a different mode, such as
PAD_CSPI1_SCLK__GPIO_4_27 above, we'd need a different naming convention.

Regards,
Amit

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
