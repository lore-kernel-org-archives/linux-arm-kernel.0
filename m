From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 3 Mar 2015 10:41:38 +0100
Subject: [PATCH] udc: gadget: atmel_usba_udc: depend on COMMON_CLK_AT91
In-Reply-To: <20150303092620.63e1861d@bbrezillon>
References: <1425368567-5333-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150303092620.63e1861d@bbrezillon>
Message-ID: <20150303094138.GC3892@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 at 09:26:20 +0100, Boris Brezillon wrote :
> >  config USB_ATMEL_USBA
> >  	tristate "Atmel USBA"
> > -	depends on AVR32 || ARCH_AT91
> > +	depends on AVR32 || ARCH_AT91 && COMMON_CLK_AT91
> 
> I guess you should add parenthesis to make it clearer ?
> 
> 	depends on AVR32 || (ARCH_AT91 && COMMON_CLK_AT91)
> 
> And I wonder why you need that. I though this option was selected by all
> at91 platforms ?
> 

That is currently the case but maybe, one day, one of the AT91 platform
will not use the same clock driver.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
