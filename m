From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Jul 2014 16:53:46 +0200
Subject: [PATCH 12/18] power: reset: Add AT91 poweroff driver
In-Reply-To: <6296F186-1B0C-4089-928A-4B0950BE847A@jcrosoft.com>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404396906-25194-22-git-send-email-maxime.ripard@free-electrons.com>
 <6296F186-1B0C-4089-928A-4B0950BE847A@jcrosoft.com>
Message-ID: <20140703145346.GG31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:31:27PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> On Jul 3, 2014, at 10:14 PM, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > 
> > Add a driver to handle the shutdown of the Atmel SoCs. This code used to be
> > (and still is) in arch/arm/mach-at91. We didn't removed it yet so that we can
> > convert all the boards to using this driver, before removing it entirely in a
> > separate patch.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > drivers/power/reset/Kconfig         |   7 ++
> > drivers/power/reset/Makefile        |   1 +
> > drivers/power/reset/at91-poweroff.c | 156 ++++++++++++++++++++++++++++++++++++
> > 3 files changed, 164 insertions(+)
> > create mode 100644 drivers/power/reset/at91-poweroff.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index b3fef01d7cbb..f9d53af50ec0 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -14,6 +14,13 @@ config POWER_RESET_AS3722
> > 	help
> > 	  This driver supports turning off board via a ams AS3722 power-off.
> > 
> > +config POWER_RESET_AT91_POWEROFF
> > +	bool "Atmel AT91 poweroff driver"
> > +	default SOC_AT91SAM9 || SOC_SAMA5
> > +	help
> > +	  This driver supports poweroff for Atmel AT91SAM9 and SAMA5
> > +	  SoCs
> > +
> > config POWER_RESET_AT91_RESET
> > 	bool "Atmel AT91 reset driver"
> > 	default SOC_AT91SAM9 || SOC_SAMA5
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index 1599214b91d9..8bf941bac3da 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -1,4 +1,5 @@
> > obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
> > +obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
> > obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
> > obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
> > obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
> > diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> > new file mode 100644
> > index 000000000000..2f2a69e9bae3
> > --- /dev/null
> > +++ b/drivers/power/reset/at91-poweroff.c
> > @@ -0,0 +1,156 @@
> > +/*
> > + * Atmel AT91 SAM9 SoCs reset code
> > + *
> > + * Copyright (C) 2014 Maxime Ripard
> > + *
> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> 
> As it?s mostly a copy of other people work you can not claim the copyright

Yep. It was a wrongful copy and paste on my side.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/0cc2c098/attachment-0001.sig>
