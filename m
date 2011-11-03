From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 Nov 2011 16:14:26 +0100
Subject: [PATCH 1/1] atmel/spi: fix missing probe during the switch to
	module_platform_driver
In-Reply-To: <CAC4N5ENm9Q+MGb89V2S6QFE0KrB72BXxEBLm7EtAvwDdJEGSjA@mail.gmail.com>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
	<CAC4N5ENm9Q+MGb89V2S6QFE0KrB72BXxEBLm7EtAvwDdJEGSjA@mail.gmail.com>
Message-ID: <20111103151426.GJ7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:55 Thu 03 Nov     , Deepak Saxena wrote:
> On Thu, Nov 3, 2011 at 10:48 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > in commit 940ab889
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> > ?arch/arm/mach-at91/include/mach/at91_aic.h | ? ?2 +-
> > ?drivers/spi/spi-atmel.c ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> > ?2 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
> > index 4b0a57e..f163bb6 100644
> > --- a/arch/arm/mach-at91/include/mach/at91_aic.h
> > +++ b/arch/arm/mach-at91/include/mach/at91_aic.h
> > @@ -20,7 +20,7 @@
> > ?extern void __iomem *at91_aic_base;
> >
> > ?#define at91_aic_read(field) \
> > - ? ? ? __raw_read(at91_aic_base + field)
> > + ? ? ? __raw_readl(at91_aic_base + field)
> >
> > ?#define at91_aic_write(field, value) \
> > ? ? ? ?__raw_writel(value, at91_aic_base + field);
> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> > index 79665e2..a691240 100644
> > --- a/drivers/spi/spi-atmel.c
> > +++ b/drivers/spi/spi-atmel.c
> > @@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
> > ? ? ? ?},
> > ? ? ? ?.suspend ? ? ? ?= atmel_spi_suspend,
> > ? ? ? ?.resume ? ? ? ? = atmel_spi_resume,
> > + ? ? ? .probe ? ? ? ? ?= atmel_spi_probe,
> > ? ? ? ?.remove ? ? ? ? = __exit_p(atmel_spi_remove),
> > ?};
> > ?module_platform_driver(atmel_spi_driver);
> 
> Jean,
> 
> This looks it should be two separate patches, one for the missing probe,
> one for the raw_read -> raw_readl.
Yes I found when I receive the e-mail and already send the v2

Best Regards,
J.
