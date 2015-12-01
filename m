From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 16:33:24 +0100
Subject: [PATCH 03/10] gpio: samsung: move gpio-samsung driver back to
 platform code
In-Reply-To: <565CEB0A.4090107@samsung.com>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
 <1448467615-447097-4-git-send-email-arnd@arndb.de>
 <565CEB0A.4090107@samsung.com>
Message-ID: <7302923.ORKinVl6Ne@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 09:34:18 Krzysztof Kozlowski wrote:
> On 26.11.2015 01:06, Arnd Bergmann wrote:
> > diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> > index 57729b915003..83697414bfa0 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -294,6 +294,9 @@ config SAMSUNG_WDT_RESET
> >         Compile support for system restart by triggering watchdog reset.
> >         Used on SoCs that do not provide dedicated reset control.
> >  
> > +config GPIO_SAMSUNG
> > +     def_bool SAMSUNG_ATAGS
> > +
> 
> I think this should be put inside "if SAMSUNG_ATAGS" section, just
> before SAMSUNG_PM_GPIO (with default=y?). It makes more consistent with
> rest of the options depending on ATAGS.

Good idea, changed that now.

> Rest seems fine:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks,

	Arnd
