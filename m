From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 5 Mar 2015 00:35:58 +0100
Subject: [PATCH 1/6] ARM: at91: switch to multiplatform
In-Reply-To: <1425511307.2090.60.camel@tiscali.nl>
References: <1425480446-31711-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425480446-31711-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1425511307.2090.60.camel@tiscali.nl>
Message-ID: <20150304233558.GK3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2015 at 00:21:47 +0100, Paul Bolle wrote :
> > +config ARCH_AT91
> > +	select ARCH_REQUIRE_GPIOLIB
> >  	select COMMON_CLK_AT91
> > -	select CPU_V7
> > +	select CLKDEV_LOOKUP
> >  	select GENERIC_CLOCKEVENTS
> > -	select MEMORY
> > -	select ATMEL_SDRAMC
> > -	select PHYLIB if NETDEVICES
> > -
> > -menu "Atmel AT91 System-on-Chip"
> > -
> > -choice
> > -
> > -	prompt "Core type"
> > -
> > -config SOC_SAM_V4_V5
> > -	bool "ARM9 AT91SAM9/AT91RM9200"
> > -	help
> > -	  Select this if you are using one of Atmel's AT91SAM9 or
> > -	  AT91RM9200 SoC.
> > +	select IRQ_DOMAIN
> > +	select NEED_MACH_IO_H if PCCARD
> > +	select PINCTRL
> > +	select PINCTRL_AT91
> > +	select SOC_BUS
> > +	select USE_OF
> > +	bool
> 
> Utterly trivial, but anyhow. Could you please make this
>     bool
> 
> line to be the line directly following the line reading
>     config ARCH_AT91
> 
> above?
> 

I can definitely do that, is your parser relying on it? :)



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
