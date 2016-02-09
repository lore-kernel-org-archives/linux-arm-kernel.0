From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 12:14:15 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
In-Reply-To: <20160209090030.GS13664@pengutronix.de>
References: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
 <20160209090030.GS13664@pengutronix.de>
Message-ID: <18237653.x9qPaNvtCU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 10:00:30 Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
> > index 1f4f2f4f25bb..fa1a7c2ca2bb 100644
> > --- a/arch/arm/mach-ks8695/board-og.c
> > +++ b/arch/arm/mach-ks8695/board-og.c
> > @@ -80,7 +80,7 @@ static void __init og_pci_bus_reset(void)
> >  #define      S8250_VIRT      0xf4000000
> >  #define      S8250_SIZE      0x00100000
> >  
> > -static struct __initdata map_desc og_io_desc[] = {
> > +static struct map_desc __initdata og_io_desc[] = {
> 
> I would have expected that
> 
> +static struct map_desc og_io_desc[] __initdata = {
> 
> is the correct variant?
> 

I think those two mean the exact same thing, and we have tons of examples
for either one in the kernel, unlike the one I removed. I have
verified that the resulting object files are identical.

Can you point me to some documentation that clarifies which one to use,
and why?

	Arnd
