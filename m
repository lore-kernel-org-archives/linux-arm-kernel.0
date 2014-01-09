From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 9 Jan 2014 03:53:15 +0000
Subject: [PATCH] spi: atmel: Refactor spi-atmel to use SPI framework queue
In-Reply-To: <52CD279B.6020203@gmail.com>
References: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
 <52CD279B.6020203@gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F45B62@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> -----Original Message-----
> From: Richard Genoud [mailto:richard.genoud at gmail.com]
> Sent: Wednesday, January 08, 2014 6:26 PM
> To: Yang, Wenyou
> Cc: broonie at kernel.org; Ferre, Nicolas; linux-spi at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] spi: atmel: Refactor spi-atmel to use SPI framework
> queue
> 
> On 08/01/2014 06:49, Wenyou Yang wrote:
> > Replace the deprecated master->transfer with transfer_one_message()
> > and allow the SPI subsystem handle all the queuing of messages.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > Hi Mark,
> >
> > The patch is based on for-next branch of
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> >
> > It is tested on sama5d3xek and at91sam9m10g45ek board.
> 
> And the bug I was seeing with SPI_IOC_MESSAGE (cf
> https://lkml.org/lkml/2013/10/8/269 ) is now gone !
> 
> Tested on at91sam9g35-ek
> 
> Tested-by: Richard Genoud <richard.genoud@gmail.com>
> 
Thanks a lot for your testing.
