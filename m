From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 09:13:56 -0800
Subject: bug of gpio transition in pinmux driver
In-Reply-To: <CAN1soZyX-jJAw4UcQUkgaYC9YosB1znbcFwiijjkyvidPXgp4w@mail.gmail.com>
References: <CAN1soZyX-jJAw4UcQUkgaYC9YosB1znbcFwiijjkyvidPXgp4w@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6DC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote at Wednesday, November 23, 2011 6:13 AM:
> Hi Linus & Stephen,
> 
> There's a bug in pinmux driver. We can request gpio via
> pinmux_request_gpio(@gpio). @gpio is the gpio number.
> 
> In pinmux_request_gpio():
>     pin = @gpio - range->base;
>     pin_request(pin);
> 
> This pin is the index of pinctrl_pin_desc[]. What's the definition of
> pinctrl_pin_desc's index? It's the index of PAD, not GPIO. Since the
> goal of pinmux_request_gpio() is to avoid define too much gpio groups.
> We need to add the transition between gpio and pad. It's clear that
> the transition of "pin = @gpio - range->base" can't fit every silicon.

> Especially, one gpio can be routed to two pads in PXA silicon.

That particular case isn't really covered yet; we've been discussing how
to solve that case; see:

https://lkml.org/lkml/2011/11/21/370

-- 
nvpublic
