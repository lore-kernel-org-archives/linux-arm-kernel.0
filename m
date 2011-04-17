From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 17 Apr 2011 22:48:16 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110417224816.38ddffee@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + * enum gpio_drive - drive modes for GPIOs (output)
> + * @GPIO_DRIVE_PUSH_PULL: the GPIO will be driven actively high and low, this
> + *	is the most typical case and is typically achieved with two active
> + *	transistors on the output
> + * @GPIO_DRIVE_OPEN_DRAIN: the GPIO will be driven with open drain (open
> + *	collector) which means it is usually wired with other output ports
> + *	which are then pulled up with an external resistor
> + * @GPIO_DRIVE_OPEN_SOURCE: the GPIO will be driven with open drain
> + *	(open emitter) which is the same as open drain mutatis mutandis but
> + *	pulled to ground

How about "off". As I've pointed out at various times some devices have
GPIO pins that may or may not be connected depending upon what other chip
logic is doing.

As I've also noted with various other previous suggestions for API
additions you also need an "unknown" state so that a device can implement
the methods but indicate for some pins the value is unknown due to
hardware or firmware limitations.
