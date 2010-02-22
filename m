From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 22 Feb 2010 22:26:59 +0200
Subject: Interrupt registering for PIO problem in ATMEL chips
In-Reply-To: <17E4CABDDEE0BC4A9F40814378DEC0CB21EB65@BLR-EC-MBX03.wipro.com>
References: <17E4CABDDEE0BC4A9F40814378DEC0CB21EB65@BLR-EC-MBX03.wipro.com>
Message-ID: <cd73a99e1002221226i5d47e60cs4b99cb911000cd52@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Also, PIOs can not distinguish between inputs and interrupts, as they
> treat everything as inputs.

Not quite.  Interrupts in GPIO input pins are optional.


> Now, my problem is I am writing this keypad driver, which is connected
> to PIOA.

There are existing GPIO-driven keypad drivers - have a look in
drivers/input/keyboard/.


> The PIOA is connected to pin 2 of AIC, but then I can not install the
> handler for pin2, It fails saying error -22 ( resource not available).
> I also don't know, what I can do even if I get to install the handler
> for PIO.

You request the interrupt only for the specific GPIO pin(s) you're
using.  You don't request all PIOA interrupts.
ie, do the following:
   request_irq(AT91_PIN_PA2, ...)


Regards,
  Andrew Victor
