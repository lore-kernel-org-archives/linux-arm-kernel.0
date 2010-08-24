From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 24 Aug 2010 17:01:43 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <19571.31677.407213.580581@ipc1.ka-ro>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<20100823125704.GU27749@pengutronix.de>
	<19571.31677.407213.580581@ipc1.ka-ro>
Message-ID: <AANLkTik9sYW9My1SDUV0zvNZaR+UME9z5Z1EMep98Dy-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/24 Lothar Wa?mann <LW@karo-electronics.de>:
> [Sacha]
> [...]
>> +static int __devinit sdma_probe(struct platform_device *pdev)
>>
> __devinit/__devexit is for hot-pluggable devices. I don't think the
> SDMA controller is hot-pluggable, so __init/__exit could be used here.

Then the .probe member has to be removed from the
struct platform_driver and platform_driver_probe() used instead
of platform_driver_register().

But it'd work fine I think.

Yours,
Linus Walleij
