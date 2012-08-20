From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 17:11:46 +0200
Subject: [PATCH 06/14] arm: at91: dt: at91sam9 add pinctrl support
In-Reply-To: <CACQ1gAjJ2HL1b9hi3RKGWWs_kW_hELAFYQ=fnHGj5nymjWdiWw@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
 <CACQ1gAjJ2HL1b9hi3RKGWWs_kW_hELAFYQ=fnHGj5nymjWdiWw@mail.gmail.com>
Message-ID: <20120820151146.GA7456@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:09 Mon 20 Aug     , Richard Genoud wrote:
> Hi Jean-Christophe,
> 
> 2012/8/10 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> > diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> > index 477cf9d..bbd2f8e 100644
> > --- a/arch/arm/mach-at91/at91sam9x5.c
> > +++ b/arch/arm/mach-at91/at91sam9x5.c
> > @@ -310,12 +310,6 @@ static void __init at91sam9x5_map_io(void)
> >         at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
> >  }
> >
> > -void __init at91sam9x5_initialize(void)
> > -{
> > -       /* Register GPIO subsystem (using DT) */
> > -       at91_gpio_init(NULL, 0);
> > -}
> > -
> >  /* --------------------------------------------------------------------
> >   *  Interrupt initialization
> >   * -------------------------------------------------------------------- */
> > @@ -323,5 +317,4 @@ void __init at91sam9x5_initialize(void)
> >  struct at91_init_soc __initdata at91sam9x5_soc = {
> >         .map_io = at91sam9x5_map_io,
> >         .register_clocks = at91sam9x5_register_clocks,
> > -       .init = at91sam9x5_initialize,
> >  };
> That's why my board wasn't booting anymore after your patchset.
> if .init is NULL, then in arch/arm/mach-at91/soc.h :
> static inline int at91_soc_is_enabled(void)
the it have the patch that drop this

Best Regards,
J.
