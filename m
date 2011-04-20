From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 14:19:04 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110418132629.12d9a106@lxorguk.ukuu.org.uk>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
Message-ID: <BANLkTimZLBG++w5b6D4EtNYPNP6H=hH+uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/18 Alan Cox <alan@lxorguk.ukuu.org.uk>:

> And for a lot of this stuff that the gpio layer really doesn't want
> internal knowledge of other chunks of the kernel have used models like
> 'get_property/set_property' (eg battery, video4linux etc) so that the mid
> layer can plumb in a conversation between the handle owner and the driver
> without getting involved in the conversation.

I will implement that when I get to consolidare the
plat-nomadik/gpio.c driver. It has custom sleep modes and
stuff noone will be interested in duplicating.

I was thinking of something along the lines of:

int gpio_set_custom(unsigned gpio, unsigned long data);
int gpio_get_custom(unsigned gpio, unsigned long *data);

So like an ioctl() it can pass in/out arbitrary data by
casting to an unsigned long, handling enums, pointers
to structs and the like.

We used this design pattern in the DMA engine, it
works fine for that.

Yours,
Linus Walleij
