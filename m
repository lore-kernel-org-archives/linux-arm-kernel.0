From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 10:14:08 +0100
Subject: [PATCH 2/6] ARM: at91: pm: use the mmio-sram pool to access SRAM
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCDFFBB@penmbx01>
References: <1421097825-396-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421097825-396-3-git-send-email-alexandre.belloni@free-electrons.com>
 <B256D81BAE5131468A838E5D7A243641BFCDFFBB@penmbx01>
Message-ID: <20150115091408.GR3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Thank you for your review.

On 15/01/2015 at 08:53:54 +0000, Yang, Wenyou wrote :
> >  config AT91_SLOW_CLOCK
> >  	bool "Suspend-to-RAM disables main oscillator"
> > +	select SRAM
> Can we move it under config ARCH_AT91 or other place?
> 
> It may be used for other purposes, more than pm. I thinks
> 

I believe it is better if every SRAM user selects SRAM so that when you
don't have any of those, it is not automatically selected and it reduces
the kernel size.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
