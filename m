From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 08 Jan 2014 11:25:31 +0100
Subject: [PATCH] spi: atmel: Refactor spi-atmel to use SPI framework queue
In-Reply-To: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
References: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <52CD279B.6020203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 06:49, Wenyou Yang wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> Hi Mark,
> 
> The patch is based on for-next branch of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> 
> It is tested on sama5d3xek and at91sam9m10g45ek board.

And the bug I was seeing with SPI_IOC_MESSAGE (cf https://lkml.org/lkml/2013/10/8/269 )
is now gone !

Tested on at91sam9g35-ek

Tested-by: Richard Genoud <richard.genoud@gmail.com>
