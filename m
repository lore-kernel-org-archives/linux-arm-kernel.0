From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Sep 2011 13:53:35 +0200
Subject: [PATCH 32/55] i2c: irq: Remove IRQF_DISABLED
In-Reply-To: <1316681962-8217-33-git-send-email-yong.zhang0@gmail.com>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
	<1316681962-8217-33-git-send-email-yong.zhang0@gmail.com>
Message-ID: <20110924135335.2be8d1be@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2011 16:58:59 +0800, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Barry Song <21cnbao@gmail.com>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c   |    4 ++--
>  drivers/i2c/busses/i2c-designware.c |    2 +-
>  drivers/i2c/busses/i2c-highlander.c |    2 +-
>  drivers/i2c/busses/i2c-nomadik.c    |    2 +-
>  drivers/i2c/busses/i2c-nuc900.c     |    2 +-
>  drivers/i2c/busses/i2c-pmcmsp.c     |    2 +-
>  drivers/i2c/busses/i2c-s3c2410.c    |    2 +-
>  drivers/i2c/busses/i2c-sh7760.c     |    2 +-
>  drivers/i2c/busses/i2c-sh_mobile.c  |    2 +-
>  drivers/i2c/busses/i2c-stu300.c     |    2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)

Ben, I'll let you pick this patch as it only touches drivers which are
under your responsibility. This will limit the risk of conflicts
between our trees.

-- 
Jean Delvare
