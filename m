From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Nov 2011 21:13:18 +0800
Subject: bug of gpio transition in pinmux driver
Message-ID: <CAN1soZyX-jJAw4UcQUkgaYC9YosB1znbcFwiijjkyvidPXgp4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus & Stephen,

There's a bug in pinmux driver. We can request gpio via
pinmux_request_gpio(@gpio). @gpio is the gpio number.

In pinmux_request_gpio():
    pin = @gpio - range->base;
    pin_request(pin);

This pin is the index of pinctrl_pin_desc[]. What's the definition of
pinctrl_pin_desc's index? It's the index of PAD, not GPIO. Since the
goal of pinmux_request_gpio() is to avoid define too much gpio groups.
We need to add the transition between gpio and pad. It's clear that
the transition of "pin = @gpio - range->base" can't fit every silicon.
Especially, one gpio can be routed to two pads in PXA silicon.

Thanks
Haojian
