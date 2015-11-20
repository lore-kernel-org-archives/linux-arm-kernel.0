From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 20 Nov 2015 09:09:01 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <20151120104017.GK19674@ibawizard.net>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
 <2750586.NCJNTpnM3N@jclayton-pc>
 <20151120104017.GK19674@ibawizard.net>
Message-ID: <20151120090901.40da06aa@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015 11:40:17 +0100
Petr ?tetiar <ynezz@true.cz> wrote:

> Joshua Clayton <stillcompiling@gmail.com> [2015-11-19 08:59:34]:
> 
> > On Thursday, November 19, 2015 03:12:05 PM Lucas Stach wrote:
> > > > +
> > > > +/* (PAD_CTL_PUS_22K_UP | PAD_CTL_PUE | PAD_CTL_PKE |
> > > > PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm) */ +#define
> > > > PAD_CTRL_PU_22k 0x0f058 +
> > > I don't particularly like those defines. Maybe just replace by
> > > the hex values?
> >
> > Seems like a genuine improvement to me,
> > except that they should not be in the dts itself.
> > Rather in arch/arm/boot/dts/imx6<num>-pinfunc.h, or another include
> > file
> 
> Ok, so how should it look like? Define bit fields and then register
> content? Something like:
> 
>   #define PAD_CTL_PUS_22K_UP              (3 << 14)
>   #define PAD_CTL_PUE                     (1 << 13)
>   #define PAD_CTL_PKE                     (1 << 12)
>   #define PAD_CTL_SPEED_LOW               (1 << 6)
>   #define PAD_CTL_DSE_80ohm               (3 << 3)
> 
Just noticed that these bits are already defined in
arch/arm/mach-imx/iomux-v3.h I'm not super familiar with dts.
Is there a good place for
them that is acceptable for both devicetree and other kernel
use?
Something like include/dt-bindings/pinctrl/iomux-v3.h ?

>   #define PAD_CTRL_PU_22k PAD_CTL_PUS_22K_UP | PAD_CTL_PUE |
> PAD_CTL_PKE | PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm
> 
This one.
Its almost always better to convey the meaning in the data
than with a separate comment.
 
> or just register value with a comment:
> 
>   /* (PAD_CTL_PUS_22K_UP | PAD_CTL_PUE | PAD_CTL_PKE |
> PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm) */ #define PAD_CTRL_PU_22k
> 0x0f058
> 
> -- ynezz
