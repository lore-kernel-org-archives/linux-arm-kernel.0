From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 30 Apr 2014 10:54:22 +0200
Subject: [PATCH v4 1/2] Documentation: Add GPIO reset binding to reset
 binding documentation
In-Reply-To: <20140417115820.GD4132@lukather>
References: <1397463709-19405-1-git-send-email-p.zabel@pengutronix.de>
 <20140417115820.GD4132@lukather>
Message-ID: <1398848062.19894.38.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Donnerstag, den 17.04.2014, 13:58 +0200 schrieb Maxime Ripard:
> I still feel like we should really treat gpios like just another reset
> controller, ie. using the resets property.

I now feel like we really shouldn't. If we do anything but use the
generic gpio bindings for reset gpios, we might force every OS or
bootloader using the device tree to implement some kind of reset
controller framework, even for hardware that only has gpio resets.

> I understand that you chose this pattern to be pretty much compatible
> with what have been done so fare, bu I don't see how to fulfill that
> goal completely, since most of the devices are actually using
> reset-gpios, but some are using other names too (including
> reset-gpio).

Yes, that is a problem that applies to all gpios, not only to reset
gpios, though.

> So if we can't be fully backward compatible, I don't see the benefit
> of being inconsistent with how reset controllers are used in general,

See above.

> and more globally on how gpios are tied for regulators for example.

Reset controllers are rather more similar to gpio or interrupt
controllers. Those also have a number of entities per device node,
as opposed to regulators.

> That would also make reset-gpio a regular reset driver, instead of
> adding logic to the core itself to handle this special case.

Which is what I initially tried and moved away from.

regards
Philipp
