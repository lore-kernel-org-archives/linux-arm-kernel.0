From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jul 2017 13:09:14 +0100
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device
 is created
In-Reply-To: <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
Message-ID: <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 09, 2017 at 12:48:10AM +0300, Andy Shevchenko wrote:
> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:

> > Tested on the IOT2000 where the second SPI bus is connected to an
> > Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> > usage.

> Can we first switch the driver to use GPIO descriptors instead of
> plain integers?

Only if you also convert the SPI core to use descriptors, Chris Packham
was looking at that but he needed update the ep93xx drivers among others
and getting reviewers was hard.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/9c025d35/attachment.sig>
