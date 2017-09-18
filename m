From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:24:02 +0200
Subject: [PATCH v4 4/6] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-5-icenowy@aosc.io>
 <445ea236-35e9-8d5a-e580-b2bdcf5f7776@free-electrons.com>
 <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
Message-ID: <20170918082402.fa5mg2ucqouh3ti5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 16, 2017 at 06:14:08PM +0800, icenowy at aosc.io wrote:
> > The H3 apparently supports IRQs, why do you not support them for the
> > temperature? They might be broken as it is on A33 but then it might be a
> > good idea to write it down in a comment in the driver (and not adding
> > the unused registers in the header file) or at least in the commit log.
> > 
> > 3) Now that you have support for clocks, wouldn't it be a good idea to
> > disable them during suspend?
> 
> Interesting... It's meaningful to disable the mod clock during suspend.

All clocks, actually. And put the device back into reset.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/ad9e3963/attachment.sig>
