From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Sep 2010 07:04:36 +0200
Subject: [PATCH 5/7] ARM: don't expose CONFIG_ZRELADDR to the users
In-Reply-To: <AANLkTinEvMREgk=UZr9RJ+FF9maeDQfDv2ZSHDppAGis@mail.gmail.com>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTikg-A7Y19vU+gShPP+zQHpNm-Wzi-m43_dm+OxL@mail.gmail.com>
	<20100903185356.GD17152@pengutronix.de>
	<AANLkTikvhJRJNOczM+n21mup+yc-VJS6OyNANUiM=x7U@mail.gmail.com>
	<AANLkTinEvMREgk=UZr9RJ+FF9maeDQfDv2ZSHDppAGis@mail.gmail.com>
Message-ID: <20100908050436.GA1614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mathieu,

On Tue, Sep 07, 2010 at 03:39:20PM -0700, Mathieu Rondonneau wrote:
> > 2010/9/4 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> On Fri, Sep 03, 2010 at 09:30:50PM +0800, Eric Miao wrote:
> >>> 2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >>> >
> >>> > This value is essential for booting a zImage and only depends on the
> >>> > memory layout of the machine to boot. ?This value was specified in
> >>> > Makefile.boot before
> >>> >
> >>> > ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
> >>> >
> >>> > and so wasn't available to change via .config.
> >>> >
> >>> > The only exception is bcmring that had a extra config for specifing the
> >>> > address used, which is removed in this commit, too, as it isn't used
> >>> > anymore since e69edc79. ?This is the only machine that still gets a
> >>> > possibility to change CONFIG_ZRELADDR.
> >>>
> >>> This looks correct to me.
> >> That's an Ack?
> >>
> >
> > Ack.
> >
> 
> I think it should be:
> 
> --- a/arch/arm/mach-bcmring/Makefile.boot
> +++ b/arch/arm/mach-bcmring/Makefile.boot
> @@ -1,6 +1,5 @@
>  # Address where decompressor will be written and eventually executed.
>  #
>  # default to SDRAM
> -zreladdr-y      := $(CONFIG_BCM_ZRELADDR)
> +zreladdr-y      := $(CONFIG_ZRELADDR)
>  params_phys-y   := 0x00000800
> 
No, the variable zreladdr-y isn't used anymore, see path 7/7.

> 
> instead of
> 
> 
> --- a/arch/arm/mach-bcmring/Makefile.boot
> +++ b/arch/arm/mach-bcmring/Makefile.boot
> @@ -1,6 +1,5 @@
>  # Address where decompressor will be written and eventually executed.
>  #
>  # default to SDRAM
> -zreladdr-y      := $(CONFIG_BCM_ZRELADDR)
>  params_phys-y   := 0x00000800
> 
> 
> -Mathieu
There is no "Mathieu" in arch/arm/mach-bcmring/Makefile.boot to remove
:-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
