From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 17:17:55 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTi=Oc+y+31KugbEy66Mp96=bf_G8Mg@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
	<BANLkTinv-MSg5Sobg2X1cJpAwPkM1Gevcg@mail.gmail.com>
	<BANLkTi=Oc+y+31KugbEy66Mp96=bf_G8Mg@mail.gmail.com>
Message-ID: <BANLkTinv_-6dJJXAWc=NFTceXGA9sabanA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Haojian Zhuang <haojian.zhuang@gmail.com>:

> I have an another question on board initialization. The configuration on pins
> are including drive strength, pull and multiple function.
>
> Since this patch can configure drive strength, pull. Will it be preferred to use
> in board initialization?

I am reusing it (inside the example driver) for drive strength and bias.

Multiple function again is pin/padmuxing.

Even if some people are only muxing pins that can also be used as GPIO,
this is not always the case. We can shunt out the same pins to be used as
I2C or SPI for example, that means this cannot be handled in a GPIO
driver since it has nothing to do with GPIO pins at all.

Thus we need an orthogonal pin/padmux mechanism.

Yours,
Linus Walleij
