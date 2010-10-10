From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 04:05:03 +0200
Subject: [PATCH 13/13] ARM: pxa: Fix pxa2xx-flash section mismatch
In-Reply-To: <AANLkTikA8-sbPbGtPbTOhyJv1CR20MHZRbvtJyh2yfkS@mail.gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
	<1286663971-15634-13-git-send-email-marek.vasut@gmail.com>
	<AANLkTikA8-sbPbGtPbTOhyJv1CR20MHZRbvtJyh2yfkS@mail.gmail.com>
Message-ID: <201010100405.03881.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 10. ??jna 2010 02:32:42 Haojian Zhuang napsal(a):
> On Sun, Oct 10, 2010 at 6:39 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  drivers/mtd/maps/pxa2xx-flash.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mtd/maps/pxa2xx-flash.c
> > b/drivers/mtd/maps/pxa2xx-flash.c index dd90880..d8ae634 100644
> > --- a/drivers/mtd/maps/pxa2xx-flash.c
> > +++ b/drivers/mtd/maps/pxa2xx-flash.c
> > @@ -51,7 +51,7 @@ struct pxa2xx_flash_info {
> >  static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
> > 
> > 
> > -static int __init pxa2xx_flash_probe(struct platform_device *pdev)
> > +static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
> >  {
> >        struct flash_platform_data *flash = pdev->dev.platform_data;
> >        struct pxa2xx_flash_info *info;
> > --
> > 1.7.1
> 
> Acked.

Can you please send me a formal acked-by line for the patches you acked ? Thanks 
and sorry for the bugging :)
