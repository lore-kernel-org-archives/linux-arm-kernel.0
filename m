From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Feb 2015 16:27:12 +0000
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
Message-ID: <20150216162712.GR14545@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Feb 2015, robert.jarzmik at free.fr wrote:

> ----- Mail original -----
> De: "Lee Jones" <lee.jones@linaro.org>
> ?: "Robert Jarzmik" <robert.jarzmik@free.fr>
> Cc: "Rob Herring" <robh+dt@kernel.org>, "Pawel Moll" <pawel.moll@arm.com>, "Mark Rutland" <mark.rutland@arm.com>, "Ian Campbell" <ijc+devicetree@hellion.org.uk>, "Kumar Gala" <galak@codeaurora.org>, "Daniel Mack" <daniel@zonque.org>, "Haojian Zhuang" <haojian.zhuang@gmail.com>, "Samuel Ortiz" <sameo@linux.intel.com>, "Grant Likely" <grant.likely@linaro.org>, devicetree at vger.kernel.org, linux-kernel at vger.kernel.org, linux-arm-kernel at lists.infradead.org, "Arnd Bergmann" <arnd@arndb.de>, "Russell King - ARM Linux" <linux@arm.linux.org.uk>, "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
> Envoy?: Lundi 16 F?vrier 2015 14:05:49
> Objet: Re: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board

What's all this?  Please configure your mail client correctly.

For advice, see:

  Documentation/email-clients.txt

> On Sat, 24 Jan 2015, Robert Jarzmik wrote:
> 
> > ---
> > Since v1: change the name from cottula to lubbock_io
> >             Dmitry pointed out the Cottula was the pxa25x family name,
> > 	    lubbock was the pxa25x development board name. Therefore the
> > 	    name was changed to lubbock_io (lubbock IO board)
> 
> > Are you sure this is what you want to do?  We don't usually support
> > 'boards' per say.  Instead we support 'devices', then pull each of
> > those devices together using some h/w description mechanism.
> 
> Do you know that :
>  1) anything under "---" in a commit message is thrown away

Yes.  But I don't remember reading this passage before.  Just becuase
this is no longer v2, it doesn't void any comments regarding v1
changelogs.

>  2) after v2, we _both_ agreed that the accurate name is "cplds"
>     which exactly what is in this patch
>     (see device registering with lubbock_cplds).

There is no mention of this decision in the changelogs.  If it's not
in the change logs, it didn't happen. ;)

I'm still concerned with the fact that the driver file is named using
and is populated by lots of instances of a "board" name.  I'm sure you
would share my thoughts is someone submitted a driver called
beaglebone.c or raspberrypi.c to MFD.

>  3) there is no more mention of "board" anywhere in the patch core

No, just the name of one.

> > Besides, this is MFD, where we support single pieces of silicon which
> > happen to support multiple devices.  I definitely don't want to support
> > boards here.
> > You might want to re-think the naming and your (sales) pitch.
> I might need help. As for the (sales), no comment.

By pitch, I mean to convince me that this belongs in MFD.

> >> +#include <linux/mfd/core.h>
> > Why have you included this?  I don't see the use of the MFD framework
> > anywhere.  So what makes this an MFD?
> I thought cplds were to be handled by an MFD driver.

Not to my knowledge, although we do appear to have one.  That doesn't
necessarily mean that it's the right place for it though.  I'm not
entirely sure how CPLDs even work on a functional level.

> > I'm going to stop here, as I think I need more of an explanation so
> > what you're trying to achieve with this driver.
> Why ? I think things were clear that this driver handles the CPLDs on
> lubbock board, namely u46 and u52. I don't understand what is wrong
> with this patch so that you don't want to go forward.

Understanding was lost when I learned that the whole file was centred
around the premise of board support.  I understand now that this is a
driver for a CPLD, which I'm not sure is even MFD.  Also, if it is
really a CPLD driver, shouldn't be named after the manufacturer/model
number of the chip, rather than the PCB which it's connected to?

I'm also concerned that this driver has no functional CPLD code
contained.  All you're doing is defining an IRQ domain.  Why then
isn't this really an drivers/irqchip (Suggested-by: Josh Cartwright)
driver?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
