From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 20 Apr 2011 16:32:38 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTinv_-6dJJXAWc=NFTceXGA9sabanA@mail.gmail.com>
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
	<BANLkTinv_-6dJJXAWc=NFTceXGA9sabanA@mail.gmail.com>
Message-ID: <20110420163238.5f0e5ea6@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Even if some people are only muxing pins that can also be used as GPIO,
> this is not always the case. We can shunt out the same pins to be used as
> I2C or SPI for example, that means this cannot be handled in a GPIO
> driver since it has nothing to do with GPIO pins at all.

It sounds very much to me like it belongs in the GPIO driver. That is the
one piece of code which knows what it is doing for all this configuration.

Whether all of this is exposed by the GPIO midlayer is another question,
certainly the GPIO midlayer/library doesn't want to be involved in the
finer details of such goings on.

The other approach to muxing I posted seems to handle this fine

Alan
