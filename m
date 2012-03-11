From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 11 Mar 2012 21:36:47 +0000
Subject: [PATCH v2 1/2] ARM: AT91: Add parameter for AT91_HAS_PATA
In-Reply-To: <20120311183856.GA13869@game.jcrosoft.org>
References: <1331415380-10928-1-git-send-email-alan@signal11.us>
 <1331415531-10961-1-git-send-email-alan@signal11.us>
 <20120311183856.GA13869@game.jcrosoft.org>
Message-ID: <201203112136.47694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > index 71feb00..9eeeabe 100644
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
> > @@ -24,6 +24,9 @@ config AT91_SAM9_ALT_RESET
> >  config AT91_SAM9G45_RESET
> >       bool
> >  
> > +config AT91_HAS_PATA
> > +     bool
> what is the need for this?
> 
> As we switch to DT, I don't want to track the soc list in the Kconfig anymore
> if the soc support the PATA will be describe in the DT
> 

When I originally wrote the patch, I was hitting build errors when trying
to enable the at91 pata driver on socs that don't have the right declarations
in their headers. If that has been resolved in a better way already, this
patch can be dropped.

	Arnd
