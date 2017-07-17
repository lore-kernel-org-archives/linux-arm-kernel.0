From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 12:22:48 -0500
Subject: [PATCH 2/3] usb: chipidea: Hook into mux framework to toggle usb
 switch
In-Reply-To: <149998498328.4532.10720468535933872401@sboyd-linaro>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
 <20170712010255.26855-3-stephen.boyd@linaro.org>
 <2db7bc39-9274-6007-d971-59e2a577d437@axentia.se>
 <149998498328.4532.10720468535933872401@sboyd-linaro>
Message-ID: <20170717172248.feign2ej7wr2s6tt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:29:43PM -0700, Stephen Boyd wrote:
> Quoting Peter Rosin (2017-07-11 23:45:24)
> > On 2017-07-12 03:02, Stephen Boyd wrote:
> > > @@ -102,4 +107,7 @@ Example:
> > >               rx-burst-size-dword = <0x10>;
> > >               extcon = <0>, <&usb_id>;
> > >               phy-clkgate-delay-us = <400>;
> > > +             mux-controls = <&usb_switch>;
> > > +             mux-control-names = "usb_switch";

Pointless to have a name when there is only 1.

> > > +             usb-switch-states = <0>, <1>;
> > 
> > I don't see the need for usb-switch-states? Just assume states 0/1 and
> > if someone later needs some other states, make them add a property that
> > overrides the defaults. Just document that 0 is host and 1 is device.
> > 
> 
> Fine by me. Rob H do you agree?

Yes.

Rob
