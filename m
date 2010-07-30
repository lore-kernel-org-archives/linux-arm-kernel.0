From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 30 Jul 2010 21:34:29 +0200
Subject: [Balloon] [PATCH 11/13] [ARM] pxa/balloon3: PCF857x
	=?utf-8?q?GPIO=09expander?= =?utf-8?q?_and=09LEDs?=
In-Reply-To: <Prayer.1.3.3.1007301954290.28463@hermes-2.csi.cam.ac.uk>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<20100730093939.GJ6845@dream.aleph1.co.uk>
	<Prayer.1.3.3.1007301954290.28463@hermes-2.csi.cam.ac.uk>
Message-ID: <201007302134.29333.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 30. ?ervence 2010 20:54:29 Paul Fidler napsal(a):
> On Jul 30 2010, Wookey wrote:
> >+++ Marek Vasut [2010-07-30 06:44 +0200]:
> >> Dne ?t 29. ?ervence 2010 12:00:41 Wookey napsal(a):
> >> > +++ Marek Vasut [2010-07-29 05:16 +0200]:
> >> > > Add supported for PCF8574A GPIO expander and LEDs attached to it.
> >> > 
> >> > This IO board is an add-on used in some ballon configurations, not
> >> > part of the core board. There needs to be some way of selecting this
> >> > support when the loon is used in this configuration. We have the
> >> > balloon_has() macro which is used for dealing with the different
> >> > builds of the board itself. Perhaps it should be extended to deal with
> >> > add-on board functionality too?
> >> > 
> >> > More obvious is using the CONFIG system to just enable this if
> >> > CUED_IO_BOARD is configured.
> >> 
> >> You can just disable the PCF driver if you want to save space. In case
> >> you won't have the CUED board connected, the driver will just fail to
> >> probe so it's ok I believe.
> >> 
> >> The macro could be extended, but do we want such a weird stuff in
> >> kernel?
> > 
> > That was how this list suggested we deal with the unprobe-able build
> > variation, I beleive.
> > 
> >> (especially if the driver can simply fail to probe).
> 
> I'd strongly recommend not adding anything at all in the kernel
> to specifically support the CUED IO Board. The LEDs attached to
> the PCF8574 on the board can be driven from user space quite easily
> using programs such as as i2cset from the i2ctools package.
> 
> We've been using these boards at CUED for a number of years now
> without any kernel support beyond i2c-pxa.ko and i2c-dev.ko.
> 
> If support is added for these LEDs in the kernel, it would be nice
> if we could still write their PCF8574 device using the i2c-dev ioctls.
> It would be inconvenient (for us) if the only way to set these LEDs
> was by writing a 1 or 0 to /sys/devices/system/leds-gpio/balloon3:gpio:ledN
> (or similar).

And also _please_ keep the CC correct. Cheers
> 
> Best wishes,
> 
>   Paul.
> 
> 
> Paul Fidler
