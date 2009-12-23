From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Dec 2009 21:45:28 +1100
Subject: [PATCH 1/4] mfd: enable max8925
In-Reply-To: <771cded00912230141o5f9cf872rd6579d9cda6720b1@mail.gmail.com>
References: <771cded00912210445v67175632i876b7909de8afae3@mail.gmail.com>
	<20091222043547.GA4411@verge.net.au>
	<771cded00912230141o5f9cf872rd6579d9cda6720b1@mail.gmail.com>
Message-ID: <20091223104528.GC16537@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 04:41:56AM -0500, Haojian Zhuang wrote:
> On Mon, Dec 21, 2009 at 11:35 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Dec 21, 2009 at 07:45:27AM -0500, Haojian Zhuang wrote:
> >> >From 567add422a0d2214e037c3ed1b424b21776dfe34 Mon Sep 17 00:00:00 2001
> >> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> Date: Thu, 17 Dec 2009 12:30:16 -0500
> >> Subject: [PATCH] mfd: enable max8925
> >>
> >> Max8925 is a Power Management IC from Maxim Semiconductor.
> >>
> >> Do basic support on accessing MAX8925.
> >>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >
> > Hi,
> >
> > It looks like max8925_device_init() needs to be annotated with __devinit
> >
> > $ make CONFIG_DEBUG_SECTION_MISMATCH=y
> > WARNING: drivers/mfd/max8925.o(.text+0x28): Section mismatch in reference
> > from the function max8925_device_init() to the function
> > .devinit.text:device_gpm_init()
> > The function max8925_device_init() references
> > the function __devinit device_gpm_init().
> > This is often because max8925_device_init lacks a __devinit
> > annotation or the annotation of device_gpm_init is wrong.
> >
> > WARNING: drivers/mfd/max8925.o(.text+0x32): Section mismatch in reference
> > from the function max8925_device_init() to the function
> > .devinit.text:device_adc_init()
> > The function max8925_device_init() references
> > the function __devinit device_adc_init().
> > This is often because max8925_device_init lacks a __devinit
> > annotation or the annotation of device_adc_init is wrong.
> >
> >
> 
> Updated the patch.
> 
> By the way, how to enable CONFIG_DEBUG_SECTION_MISMATCH? I found that
> this config is dependant on CONFIG_UNDEFINED. I can't find who defines
> CONFIG_UNDEFINED in kernel.

Thanks, the new version fixes the problem that I noticed.

I've always just enabled CONFIG_DEBUG_SECTION_MISMATCH on the command
line rather than through .config. That is, I run:

make CONFIG_DEBUG_SECTION_MISMATCH=y
