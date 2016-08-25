From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 09:23:43 +0200
Subject: [PATCH 10/10] reset: hi6220: allow to compile test driver on
 other architectures
In-Reply-To: <CAK7LNAQd770utOisbeAZearej4pf0scbRnP+mkbU=MUCV-1CXQ@mail.gmail.com>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-10-git-send-email-p.zabel@pengutronix.de>
 <CAK7LNAQd770utOisbeAZearej4pf0scbRnP+mkbU=MUCV-1CXQ@mail.gmail.com>
Message-ID: <1472109823.3032.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.08.2016, 03:00 +0900 schrieb Masahiro Yamada:
> 2016-08-24 22:29 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > Also remove the RESET_CONTROLLER dependency, this Kconfig file is
> > included inside the menuconfig already.
> >
> > Cc: Chen Feng <puck.chen@hisilicon.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/hisilicon/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/hisilicon/Kconfig b/drivers/reset/hisilicon/Kconfig
> > index 26bf95a..1ff8b0c 100644
> > --- a/drivers/reset/hisilicon/Kconfig
> > +++ b/drivers/reset/hisilicon/Kconfig
> > @@ -1,5 +1,6 @@
> >  config COMMON_RESET_HI6220
> >         tristate "Hi6220 Reset Driver"
> > -       depends on (ARCH_HISI && RESET_CONTROLLER)
> > +       depends on ARCH_HISI || COMPILE_TEST
> > +       default ARCH_HISI
> >         help
> >           Build the Hisilicon Hi6220 reset driver.
> > --
> > 2.8.1
> >
> 
> 
> As you see
> 
> obj-$(CONFIG_ARCH_HISI) += hisilicon/
> 
> in drivers/reset/Makefile,
> Kbuild can descend into drivers/reset/hisilicon/
> only when CONFIG_ARCH_HISI is enabled.
> 
> So, this patch does not add compile-test'ability.
> 
> 
> Currently, I only see a single file in drivers/reset/hisilicon/ directory,
> but perhaps they might be planning to add more reset drivers for
> other Hisilicon SoCs in the future.
> 
> 
> Change to
> 
> obj-y += hisilicon/

Good catch, I'll do that for now ...

> or
> 
> create "config RESET_HISI" as a vendor-common option and
> 
> obj-$(CONFIG_RESET_HISI)  += hisilicon/
> 
> ?

... since I'm not quite sure if there are currently patches selecting
COMMON_RESET_HI6220 floating around.

regards
Philipp
