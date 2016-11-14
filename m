From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 14:10:46 +0100
Subject: [linux-sunxi] Re: [PATCH 3/3] ARM: dts: sunxi: add support for
 Orange Pi Zero board
In-Reply-To: <cbbf8ae1-ff29-2a83-265b-a9ff5bacf97b@redhat.com>
References: <20161111164654.15273-1-icenowy@aosc.xyz>
 <20161111164654.15273-3-icenowy@aosc.xyz>
 <20161114085839.qzu7ebeghoqlqygn@lukather>
 <CAGb2v677zQGihbz1o2izM-y5GJ4VDApf6-WDJAk3UyZdsK-vWQ@mail.gmail.com>
 <cbbf8ae1-ff29-2a83-265b-a9ff5bacf97b@redhat.com>
Message-ID: <20161114131046.t2iy3imx5ozcgrp6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 11:00:32AM +0100, Hans de Goede wrote:
> > > > +&usbphy {
> > > > +     /* USB VBUS is always on */
> > > 
> > > You can put the always on regulators (I'm guessing reg_vcc5v0 ?) here.
> > 
> > AFAIK the regulator properties are optional the the USB PHY.
> > So we probably don't need to add it. Hans (CC-ed) could explain
> > his original intent?
> 
> I've made the regulators optional exactly for boards like these,
> where there is no regulator. Likely the Vbus is simply wired
> directly to the 5V DC-in jack. So IMHO adding something like
> the fixed reg_vcc5v0 a supply here just makes the dt
> harder to read.

It also makes the regulator tree more complete and accurate because
you'd list all the devices that are needing those regulators. That
would also make it easier to deal with in the future.

But fair enough.
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/4cfb2c48/attachment.sig>
