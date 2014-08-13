From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Aug 2014 11:09:19 -0700
Subject: PL310 cache initialization/fixup for BCM63138
Message-ID: <53EBA9CF.4030902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Arnd,

The PL310 cache present on BCM63138 comes up with wrong values out of
reset in particular, I need to at least override the way-size to be
32KiB otherwise.

Right now, I am overriding the auxiliary control register by supplying a
non 0xffffffff aux_ctrl_mask to l2x0_of_init().

Should I rather use a separate compatible string for it and perform the
"fixup" in a separate of_parse() callback, or in a separate fixup()
callback?

Or is it recommended to keep overriding the aux_ctrl_mask as part of the
call to l2x0_of_init()?

Thanks!
--
Florian
