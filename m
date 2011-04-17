From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 17 Apr 2011 23:03:14 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTimwbsmQw0Dawz_+LpVf+wU60AbB0g@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<20110417224816.38ddffee@lxorguk.ukuu.org.uk>
	<BANLkTimwbsmQw0Dawz_+LpVf+wU60AbB0g@mail.gmail.com>
Message-ID: <20110417230314.23350cbd@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Apr 2011 23:58:16 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> 2011/4/17 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> 
> >> + * enum gpio_drive - drive modes for GPIOs (output)
> >> + * @GPIO_DRIVE_PUSH_PULL: the GPIO will be driven actively high and low, this
> >> + * ? is the most typical case and is typically achieved with two active
> >> + * ? transistors on the output
> >> + * @GPIO_DRIVE_OPEN_DRAIN: the GPIO will be driven with open drain (open
> >> + * ? collector) which means it is usually wired with other output ports
> >> + * ? which are then pulled up with an external resistor
> >> + * @GPIO_DRIVE_OPEN_SOURCE: the GPIO will be driven with open drain
> >> + * ? (open emitter) which is the same as open drain mutatis mutandis but
> >> + * ? pulled to ground
> >
> > How about "off". As I've pointed out at various times some devices have
> > GPIO pins that may or may not be connected depending upon what other chip
> > logic is doing.
> 
> Sure, why not.
> 
> > As I've also noted with various other previous suggestions for API
> > additions you also need an "unknown" state so that a device can implement
> > the methods but indicate for some pins the value is unknown due to
> > hardware or firmware limitations.
> 
> OK do you want an unknown biasing mode too, or is "floating" enough
> of a default to cover that?

I think I'd rather also have unknown for both the drive and the biasing.
It's a way of ensuring we get some kind of complete coverage even if not
perfect.

In the Intel case we also have 'alt status' stuff where the line has been
borrowed by firmware for example so we really genuinly haven't got a clue
what the state is right now.
