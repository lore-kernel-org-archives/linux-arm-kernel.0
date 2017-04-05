From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 5 Apr 2017 14:16:55 -0300
Subject: [RFC] [media] imx: assume MEDIA_ENT_F_ATV_DECODER entities
 output video on pad 1
In-Reply-To: <CAGoCfiyfXc2bcTR72XwL3Vv8ny-dQUjEUk2OUuy_s4nedNJqxA@mail.gmail.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1490894749.2404.33.camel@pengutronix.de>
 <20170404231053.GE7909@n2100.armlinux.org.uk>
 <19f0ce92-cad6-8950-8018-e3224e2bf266@gmail.com>
 <7235285c-f39a-64bc-195a-11cfde9e67c5@gmail.com>
 <20170405082134.GF7909@n2100.armlinux.org.uk>
 <1491384859.2381.51.camel@pengutronix.de>
 <20170405115336.7135e542@vento.lan>
 <CAGoCfizXdDV_Eo1NSOAb+-wrC7F47iFQKyP8-wiJMpb-nsYArA@mail.gmail.com>
 <20170405131725.22c13a1d@vento.lan>
 <CAGoCfiyfXc2bcTR72XwL3Vv8ny-dQUjEUk2OUuy_s4nedNJqxA@mail.gmail.com>
Message-ID: <20170405141655.46a46b72@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, 5 Apr 2017 13:02:52 -0400
Devin Heitmueller <dheitmueller@kernellabs.com> escreveu:

> > I remember I looked on this when I wrote the driver, but I was
> > unable to find a way for em28xx to parse (or forward) such
> > data packets.  
> 
> I'm pretty sure it's possible, but I haven't looked at the datasheets
> in a number of years and don't recall the details.
> 
> Hardware VBI splicing is supported by a number of decoders but it's
> rarely used on commodity PCs (the Conexant and NXP decoders support it
> as well).  That said, I won't argue there might be some value on
> really low end platforms.  All I would ask is that if you do introduce
> any such functionality into the tvp5150 driver for some embedded
> application that you please not break support for devices such as the
> em28xx.

Yeah, sure. If I write such patchset[1], it will be optional, and
will depend on a DT variable (or platform_data) setup that would
tell what GPIO pin should be used for interrupt.

Not providing it should either disable such feature or enable it
via polling.

[1] Please notice that I don't have any demand of doing it. Yet,
I may do it for fun on my spare time:-)

I added in the past an initial support for sliced VBI API on em28xx, 
with got reverted on changeset 1d179eeedc8cb48712bc236ec82ec6c63af42008, 
mainly due to the lack of such feature on tvp5150. So, such code was never
tested (and likely need fixes/updates), but if I end by adding sliced VBI
support on tvp5150 and on OMAP3, I may add support for it on em28xx too,
using I2C poll. On such case, I'll likely add a modprobe parameter to
enable such feature.

Thanks,
Mauro
