From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 06:13:36 +0200
Subject: [PATCH 14/14] at91: move clock subsystem init to soc generic init
In-Reply-To: <4DB63841.1060903@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303780300-2205-2-git-send-email-plagnioj@jcrosoft.com>
	<4DB63841.1060903@bluewatersys.com>
Message-ID: <20110426041336.GC12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:13 Tue 26 Apr     , Ryan Mallon wrote:
> On 04/26/2011 01:11 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> 
> <snip>
> 
> >  /* --------------------------------------------------------------------
> > diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
> > index c82d219..2d4e415 100644
> > --- a/arch/arm/mach-at91/soc.c
> > +++ b/arch/arm/mach-at91/soc.c
> > @@ -115,7 +115,10 @@ void __init at91_initialize(unsigned long main_clock)
> >  
> >  	pr_info("AT91: detected soc: %s\n", current_soc.name);
> >  
> > -	current_soc.init(main_clock);
> > +	current_soc.init();
> 
> I think this patch should go near the beginning of the series so that
> current_soc.init never needs to take an argument.
no until you factorize the at91_init_clock you do need it

Best Regards,
J.
