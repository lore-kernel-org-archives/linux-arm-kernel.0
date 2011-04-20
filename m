From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 20 Apr 2011 17:13:41 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
Message-ID: <BANLkTinaOk4Qq+uwdZQtapncwjpdTg9wmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Haojian Zhuang <haojian.zhuang@gmail.com>:

> Before suspend, it may be configured as some function that isn't GPIO.
> Is it a goal
> that avoid declaring gpio_request() for suspend and updating the setting of pin?

I refer to that as a totally different use case "pinmux or padmux"
which I think we are better off treating as totally orthogonal to GPIO.

I have loose ideas to break pin/pad muxing into a separate driver
directory under drivers/pinpadmux or something.

Some people inevitably think that GPIO and pin/padmux are
intertwined, but as far as I have seen they are not. However there
may be a cross dependency so that a GPIO driver may need to
export an additional pin/padmux interface or so, e.g we have
a separate chip in I2C which can mux pins...

However this is a separate issue altogether, I think we can assume
pin/padmuxing is in the board code until we have a suitable
solution for a framework for that. (Don't know if I'll be able to write
one though.)

> Are these two patches are post in mailing list? I can't find your
> second patch in this
> patch series?

I can see it here ... ?

Yours,
Linus Walleij
