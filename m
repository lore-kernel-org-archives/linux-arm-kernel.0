From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Mar 2014 17:23:56 +0800
Subject: [PATCH 1/4] mfd: mc13xxx: Honor designed SPI mode
In-Reply-To: <1393833357.545249459@f190.i.mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <20140303073524.GD4674@lee--X1>
 <1393833357.545249459@f190.i.mail.ru>
Message-ID: <20140303092356.GA8282@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ???????????,  3 ????? 2014, 15:35 +08:00 ?? Lee Jones <lee.jones@linaro.org>:
> > > Instead of using hard coded SPI mode, use mode described in
> > > devicetree or defined for the board.
> > > Additionally, patch updates all users of this PMIC to use
> > > correct SPI mode.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-imx/mach-mx31lilly.c | 1 +
> > >  arch/arm/mach-imx/mach-mx31lite.c  | 1 +
> > >  drivers/mfd/mc13xxx-spi.c          | 2 --
> > 
> > There's no reason for these changes to be in the same patch.
> > 
> > Please split them up by subsystem and resubmit.
> 
> This should be in one patch, since it cause to break functionality of these
> boards due missing SPI_CS_HIGH property in the spi_board_info.

Okay, I'll take your word for it.

For the MFD part:
  Acked-by: Lee Jones <lee.jones@linaro.org>

I'm happy to take this through the MFD tree and can provide an
immutable branch for the other Maintainers if requested.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
