From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 26 Jan 2015 01:10:06 +0000
Subject: [PATCH 05/12] ARM: at91: move select SRAM to ARCH_AT91
In-Reply-To: <20150123102426.GG19922@piout.net>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
 <1421741825-18226-6-git-send-email-wenyou.yang@atmel.com>
 <20150123102426.GG19922@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD32739@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Thank you for your review.

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Friday, January 23, 2015 6:24 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; sylvain.rochet at finsecur.com; peda at axentia.se
> Subject: Re: [PATCH 05/12] ARM: at91: move select SRAM to ARCH_AT91
> 
> On 20/01/2015 at 16:16:58 +0800, Wenyou Yang wrote :
> > Because the CONFIG_AT91_SLOW_CLOCK will be removed to simply the PM
> > config, so move select SRAM.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> > ---
> >  arch/arm/mach-at91/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > index 56dcede..7d5e201 100644
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
> > @@ -6,6 +6,7 @@ config ARCH_AT91
> >  	select PINCTRL
> >  	select PINCTRL_AT91
> >  	select USE_OF
> > +	select SRAM if PM
> >  	bool
> >
> >  menuconfig SOC_SAM_V7
> > @@ -128,7 +129,6 @@ comment "AT91 Feature Selections"
> >
> >  config AT91_SLOW_CLOCK
> >  	bool "Suspend-to-RAM disables main oscillator"
> > -	select SRAM
> >  	depends on SUSPEND
> >  	help
> >  	  Select this if you want Suspend-to-RAM to save the most power
> > --
> > 1.7.9.5
> >
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
Best Regards,
Wenyou Yang
