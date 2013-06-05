From: mikedunn@newsguy.com (Mike Dunn)
Date: Wed, 05 Jun 2013 10:23:16 -0700
Subject: pxa27x and pinctrl-single
Message-ID: <51AF7404.3090003@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to start converting to device tree usage some of the old pxa27x
platforms I'm fond of, starting with adding pinctrl support.  If I'm not
mistaken, this will clear the way for some ongoing updates to the pinctrl/gpio
code used by newer Marvell arches.

I noticed that Haojian pulled the pinctrl-pxa driver from the kernel, in favor
of using pinctrl-single, so I turned my attention to that.  From what I can
tell, pinctrl-single is currently inadequate for pxa27x because:

(1) On the pxa27x, setting the mux for a pin involves configuring both the alt
function register *and* the direction register, requiring the ability to specify
in the device tree multiple reg/value pairs for each pin.

(2) Some of the pinctrl-single code still assumes one register-per-pin; see for
example the functions pcs_allocate_pin_table() and pcs_get_pin_by_offset().
Curiously, the recently added pcs_request_gpio() function also suffers from
this, unless I'm mistaken.

So I'm wondering if it's appropriate to patch pinctrl-single to make it suitable
for pxa27x, or should there be a separate driver for pxa27x?

Normally I'd just submit a patch for consideration, but I think that work is
ongoing, so maybe I better ask first in case other plans are in progress.  Plus
I'm new to pinctrl and device tree.  Any comments, suggestions, hints, etc
appreciated.

Thanks,
Mike
