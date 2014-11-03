From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Nov 2014 11:11:02 +0100
Subject: [PATCH v2 0/4] Add support for pxa27x device-tree machine
In-Reply-To: <87a94891sm.fsf@free.fr>
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
 <1830013.l3PUsHBfsL@wuerfel> <87a94891sm.fsf@free.fr>
Message-ID: <3391686.6Ux0ymi7iy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 November 2014 08:32:57 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 30 October 2014 07:55:48 Robert Jarzmik wrote:
> > Whole series
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> Thanks Arnd.
> 
> Unfortunately my checkers caught a flaw in the non-device tree case :
>  - pxa27x_dt_init_irq() is defined, even if unused
>  - it calls pxa_dt_irq_init(), which is conditionaly defined on CONFIG_OF
>    => breaks non DT builds
> 
> So I'll have to enclose this function in a #if defined(CONFIG_OF), and respin
> patch 1.

Please make it use 

	if (IS_ENABLED(CONFIG_OF))
		pxa_dt_irq_init(pxa27x_set_wake);

so we get the build-time coverage.

	Arnd
