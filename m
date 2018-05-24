From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 May 2018 19:16:28 +0100
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <20180524175620.GB12093@piout.net>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
 <20180517045437.GE20254@sirena.org.uk>
 <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
 <20180524175620.GB12093@piout.net>
Message-ID: <20180524181628.GE4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 07:56:20PM +0200, Alexandre Belloni wrote:

> Back in 2014, I was suggesting using devm_gpio_request_one() in
> of_spi_register_master(). That would take care of setting the direction
> of the GPIO:

> https://www.spinics.net/lists/arm-kernel/msg351251.html

> I never took the time to create the patch and test though.

Right, this'd be ideal but unfortunately it does mean we'd have to
transition all the existing users that open code their requests which is
a pain.  It'd be really nice if someone had the time/enthusiam to do it
though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/4bbd58ed/attachment.sig>
