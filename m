From: wookey@wookware.org (Wookey)
Date: Fri, 30 Jul 2010 10:39:40 +0100
Subject: [PATCH 11/13] [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
In-Reply-To: <201007300644.04710.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-11-git-send-email-marek.vasut@gmail.com>
	<20100729100040.GA4981@dream.aleph1.co.uk>
	<201007300644.04710.marek.vasut@gmail.com>
Message-ID: <20100730093939.GJ6845@dream.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Marek Vasut [2010-07-30 06:44 +0200]:
> Dne ?t 29. ?ervence 2010 12:00:41 Wookey napsal(a):
> > +++ Marek Vasut [2010-07-29 05:16 +0200]:
> > > Add supported for PCF8574A GPIO expander and LEDs attached to it.
> > 
> > This IO board is an add-on used in some ballon configurations, not
> > part of the core board. There needs to be some way of selecting this
> > support when the loon is used in this configuration. We have the
> > balloon_has() macro which is used for dealing with the different
> > builds of the board itself. Perhaps it should be extended to deal with
> > add-on board functionality too?
> > 
> > More obvious is using the CONFIG system to just enable this if
> > CUED_IO_BOARD is configured.
> 
> You can just disable the PCF driver if you want to save space. In case you won't 
> have the CUED board connected, the driver will just fail to probe so it's ok I 
> believe.
> 
> The macro could be extended, but do we want such a weird stuff in kernel? 

That was how this list suggested we deal with the unprobe-able build variation, I
beleive.

> (especially if the driver can simply fail to probe).

No. Clearly anything that is probe-able should be probed. I thought
thtat this wouldn't be as I2C devices are pretty dumb, but I guess we
know its address here so we can try it and if no response then it's
not there.

Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/
