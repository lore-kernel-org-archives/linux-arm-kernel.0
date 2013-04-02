From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 01:35:08 +0200
Subject: [PATCH V2 10/12] spi/mxs: Clean up setup_transfer function
In-Reply-To: <1364905195-24286-10-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <1364905195-24286-10-git-send-email-tpiepho@gmail.com>
Message-ID: <201304030135.09072.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> It can't be called with a NULL transfer anymore so it can be
> simplified to not check for that.
> 
> Change printouts to more closely match what the spi core would print.
> I.e., don't print function names.  Try to make them clearer.
> 
> Fix indention of line-wrapped code to Linux standard.
> 
> The transfer pointer can be const.
> 
> It's not necessary to check if the spi_transfer's bit per word is
> zero.  The spi core automatically inserts the spi_device's bits per
> word in that case.
> 
> It's not necessary to check if the spi_transfer's speed_hz is zero, as
> the spi core also fills it in from the spi_device.  However, the spi
> core does not check if spi_device's speed is zero so we have to do
> that still.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Ok, this is again combining cleanup and fixup/feature changes. You know what to 
do by now.

btw it might be nice to reorder the series so that cleanups go in first as 
they're easy and fixes afterwards.

Best regards,
Marek Vasut
