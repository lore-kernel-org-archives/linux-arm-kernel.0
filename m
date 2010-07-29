From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 29 Jul 2010 15:53:19 +0200
Subject: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
In-Reply-To: <20100729123443.GA18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> What now needs to happen is the sense of the GPIOLIB support on platforms
> needs to be checked - eg, I suspect the card detect via the GPIO primecell
> is inverted on Realview - in which case we need a 'cd_invert' rather
> than the negative 'cd_noinvert'.

Doesn't seem so. I applied this patch and it works like a charm just
like before on PB1176. (PL061 is compiled in, so it's not that other
weird stuff being used.)

I hope I'm doing the right thing, boot with card inserted, this appears
in the bootlog:

mmc0: new SD card at address 80ca
mmcblk0: mmc0:80ca SU512 483 MiB
 mmcblk0: p1

Remove card:
mmc0: card 80ca removed

Insert card:
mmc0: new SD card at address 80ca
mmcblk0: mmc0:80ca SU512 483 MiB
 mmcblk0: p1

And so on.

Yours,
Linus Walleij
