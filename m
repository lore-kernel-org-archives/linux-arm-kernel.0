From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 19 Nov 2015 08:59:34 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <1447942325.3144.86.camel@pengutronix.de>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
Message-ID: <2750586.NCJNTpnM3N@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 19, 2015 03:12:05 PM Lucas Stach wrote:
> > +
> > +/* PAD Ctrl values for common settings */
> > +/* (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm) */
> > +#define PAD_CTRL_HYS_PU 0x1b0b0
> > +
> > +/* (PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm) */
> > +#define PAD_CTRL_HYS_PD 0x130b0
> > +
> > +/* (PAD_CTL_PUS_22K_UP | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm) */
> > +#define PAD_CTRL_PU_22k 0x0f058
> > +
> I don't particularly like those defines. Maybe just replace by the hex
> values?
Hold on. Lets not throw the baby out with the bathwater.
These macros (or something similar) look much nicer than hex values that I
have to look up in the imx6 user manual over and over.

Seems like a genuine improvement to me,
except that they should not be in the dts itself.
Rather in arch/arm/boot/dts/imx6<num>-pinfunc.h, or another include file

What do you think?

> 
> > +#define PAD_CTRL_NO 0x80000000
> > +
> No pad control isn't okay for new DTs. Even if the pin should stay at
> the hardware reset default, it must be explicitly set in the DT. Please
> look up the defaults in the reference manual and replace any occurrence
> of 0x80000000 with the real value.
> 
Not sure about this one since we actively discourage 0x80000000

-- 
~Joshua Clayton
