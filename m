From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 11:25:26 +0200
Subject: [PATCH V3 5/5] input: pxa27x-keypad: add device tree support
In-Reply-To: <CADApbeiQWOi8SYEFf0bOsf1yn+TgXhwgDWaWFpGk7+nbC9bNDg@mail.gmail.com>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
 <201306191022.51630.marex@denx.de>
 <CADApbeiQWOi8SYEFf0bOsf1yn+TgXhwgDWaWFpGk7+nbC9bNDg@mail.gmail.com>
Message-ID: <5961561.7UgodVjTLY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013 16:38:38 Chao Xie wrote:
> >> index 0000000..f8674f7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> >> @@ -0,0 +1,60 @@
> >> +* Marvell PXA Keypad controller
> >> +
> >> +Required Properties
> >> +- compatible : should be "marvell,pxa27x-keypad"
> >> +- reg : Address and length of the register set for the device
> >> +- interrupts : The interrupt for the keypad controller
> >> +- marvell,debounce-interval : How long time the key will be
> >
> > Is there no generic prop name for this debounce interval?
> >
> I searched at drivers/input and Documents.
> Two drivers use "debounce-interval", gpio-keys.c and stmpe-keypad.c.
> They describe the meanings of "debounce-interval" at its own document file.
> Some other drivers uses "xxx,debounce-delay-ms" or "debounce-delay-ms"
> So it seems that there is no generic prop name for this debounce interval.

I'd suggest using "debounce-interval" as in gpio-keys then, since that
is the most generic driver.

	Arnd
